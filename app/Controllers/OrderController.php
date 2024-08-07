<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderPromotion;
use App\Models\Product;
use App\Models\Promotion;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;

class OrderController extends BaseController
{
    protected $orderModel;
    protected $orderItemModel;
    protected $productModel;
    protected $promotionModel;
    protected $orderPromotionModel;

    use ResponseTrait;

    public function __construct()
    {
        $this->orderModel = new Order();
        $this->orderItemModel = new OrderItem();
        $this->productModel = new Product();
        $this->promotionModel = new Promotion();
        $this->orderPromotionModel = new OrderPromotion();
    }

    public function create()
    {
        try {
            // Start transaction
            $this->orderModel->transBegin();

            $data = $this->request->getJSON(true);

            $orderData = [
                'id_table' => $data['id_table'],
                'order_date' => date('Y-m-d H:i:s'),
            ];

            $orderId = $this->orderModel->insert($orderData);

            if ($orderId < 1) {
                throw new \DatabaseException('Failed to save order');
            }

            // Insert order items
            if (!empty($data['products'])) {

                $products = $data['products'];

                $payloadOrderItems = array_map(function ($product) use ($orderId) {
                    return [
                        'id_order' => $orderId,
                        'id_product' => $product['id_product'],
                        'quantity' => $product['quantity'],
                    ];
                }, $products);

                $orderItem = $this->orderItemModel->insertBatch($payloadOrderItems);

                if ($orderItem < 1) {
                    throw new \DatabaseException("Failed to create order items");
                }
            }

            // Insert order promotions
            if (!empty($data['promotions'])) {
                $promotions = $data['promotions'];

                $payloadOrderPromotion = array_map(function ($product) use ($orderId) {
                    return [
                        'id_order' => $orderId,
                        'id_promotion' => $product['id_promotion'],
                        'quantity' => $product['quantity'],
                    ];
                }, $promotions);

                $orderPromotion = $this->orderPromotionModel->insertBatch($payloadOrderPromotion);

                if ($orderPromotion < 1) {
                    throw new \DatabaseException("Failed to create order promotions");
                }
            }

            $products = $this->productCollection($data['products']);

            $dataItemsDapur = array_values(array_filter($products, function ($item) {
                return $item['id_category'] == 1;
            }));

            $dataItemsBar = array_values(array_filter($products, function ($item) {
                return $item['id_category'] == 2;
            }));

            $promotions = $this->promotionCollection($data['promotions']);

            $dataPromotionDapur = array_values(array_filter($promotions, function ($item) {
                return $item['id_category'] == 1;
            }));

            $dataPromotionBar = array_values(array_filter($promotions, function ($item) {
                return $item['id_category'] == 2;
            }));

            $mergeOrderDapur = array_merge($dataItemsDapur, $dataPromotionDapur);
            $mergeOrderBar = array_merge($dataItemsBar, $dataPromotionBar);

            $payloadOrderDapur = array_map(function ($item) {
                return [
                    'item_name' => $item['item_name'],
                    'variant' => $item['variant'],
                    'quantity' => $item['quantity'],
                ];
            }, $mergeOrderDapur);

            $payloadOrderBar = array_map(function ($item) {
                return [
                    'quantity' => $item['quantity'],
                    'item_name' => $item['item_name'],
                    'variant' => $item['variant'],
                ];
            }, $mergeOrderBar);

            $billResponse = $this->printBill($orderId);
            $billData = $billResponse->getBody(); // Ambil body dari respons printBill

            if ($this->orderModel->transStatus() === FALSE) {
                throw new \Exception("Error transaction");
            }

            $this->orderModel->transCommit();
            return $this->respondCreated([
                'message' => 'Order created successfully',
                'order_number' => $orderId,
                'printer_kasir' => json_decode($billData, true),
                'printer_dapur' => $payloadOrderDapur,
                'printer_bar' => $payloadOrderBar
            ]);
        } catch (\DatabaseException $e) {
            $this->orderModel->transRollback();
            return $this->fail($e->getMessage());
        } catch (\Exception $e) {
            $this->orderModel->transRollback();
            return $this->fail('An unexpected error occurred: ' . $e->getMessage());
        }
    }

    public function printBill($orderId)
    {
        $order = $this->orderModel->getOrderById($orderId);

        if (!$order) {
            return $this->failNotFound('Order not found');
        }

        $orderItems = $this->orderItemModel->getOrderItemsByOrderId($orderId);

        $orderPromotions = $this->orderPromotionModel->getPromotionsByOrderId($orderId);

        if (!$orderItems && !$orderPromotions) {
            return $this->failNotFound('Order items or promotions not found');
        }

        $payloadOrderItems = array_map(function ($item) {
            return [
                'quantity' => $item['quantity'],
                'item_name' => $item['product_name'],
                'variant' => $item['variant'],
                'price' => $item['price'],
            ];
        }, $orderItems);


        $total = 0;
        foreach ($orderItems as $item) {
            // $product = $this->productModel->find($item['id_product']);
            $total += $item['price'] * $item['quantity'];
        }
        foreach ($orderPromotions as $promotion) {
            $total += $promotion['price'];
        }

        $payloadOrderItems = array_map(function ($item) {
            return [
                'quantity' => $item['quantity'],
                'item_name' => $item['product_name'],
                'variant' => $item['variant'],
                'price' => $item['price'],
                'total_price' => number_format($item['price'] * $item['quantity'], 2, '.', ''),
            ];
        }, $orderItems);

        $payloadOrderPromotion = array_map(function ($item) {
            return [
                'quantity' => $item['quantity'],
                'item_name' => $item['promotion_name'],
                'variant' => 'No Variant',
                'price' => $item['price'],
                'total_price' => number_format($item['price'] * $item['quantity'], 2, '.', ''),
            ];
        }, $orderPromotions);

        $payload = [
            'message' => 'Order retrieved successfully',
            'data' => [
                'order' => $order,
                'items' => $payloadOrderItems,
                'promotions' => $payloadOrderPromotion,
                'total' => number_format($total, 2, '.', ''),
            ]
        ];

        return $this->respond($payload, 200);
    }

    public function printMenu($orderId, $categoryId)
    {
        $order = $this->orderModel->getOrderById($orderId);

        if (!$order) {
            return $this->failNotFound('Order not found');
        }

        $orderItems = $this->orderItemModel->getOrderItemsByOrderId($orderId);

        $orderPromotions = $this->orderPromotionModel->getPromotionsProductByOrderId($orderId);

        if (!$orderItems && !$orderPromotions) {
            return $this->failNotFound('Order items or promotions not found');
        }

        $filterOrderItems = array_values(array_filter($orderItems, function ($item) use ($categoryId) {
            return $item['id_category'] == $categoryId;
        }));

        $filterOrderPromotion = array_values(array_filter($orderPromotions, function ($item) use ($categoryId) {
            return $item['id_category'] == $categoryId;
        }));

        $payloadOrderItems = array_map(function ($item) {
            return [
                'quantity' => $item['quantity'],
                'item_name' => $item['product_name'],
            ];
        }, $filterOrderItems);

        $payloadOrderPromotion = array_map(function ($item) {
            return [
                'quantity' => $item['quantity'],
                'item_name' => $item['product_name'],
            ];
        }, $filterOrderPromotion);

        $items = array_merge($payloadOrderItems, $payloadOrderPromotion);

        $payload = [
            'message' => 'Order retrieved successfully',
            'data' => [
                'order' => $order,
                'items' => $items
            ]
        ];

        return $this->respond($payload, 200);
    }

    private function productCollection($products)
    {
        $idProducts = array_column($products, 'id_product');
        $dataProduct = $this->productModel->whereIn('id_product', $idProducts)->findAll();

        $resultProduct = [];
        foreach ($products as $apiProduct) {
            foreach ($dataProduct as $dbProduct) {
                if ($apiProduct['id_product'] == $dbProduct['id_product']) {
                    // Gabungkan data dari API dan database
                    $resultProduct[] = [
                        "id_product" => $dbProduct['id_product'],
                        "quantity" => $apiProduct['quantity'],
                        "id_category" => $dbProduct['id_category'],
                        "item_name" => $dbProduct['product_name'],
                        "variant" => $dbProduct['variant']
                    ];
                }
            }
        }

        return $resultProduct;
    }

    private function promotionCollection($promotions)
    {
        $idPromotion = array_column($promotions, 'id_promotion');
        $dataPromotion = $this->promotionModel->getPromotionsProductByIdPromotion($idPromotion);

        $resultPromotion = [];
        foreach ($promotions as $apiProduct) {
            foreach ($dataPromotion as $dbProduct) {
                if ($apiProduct['id_promotion'] == $dbProduct['id_promotion']) {
                    // Gabungkan data dari API dan database
                    $resultPromotion[] = [
                        "id_product" => $dbProduct['id_product'],
                        "quantity" => $apiProduct['quantity'],
                        "id_category" => $dbProduct['id_category'],
                        "item_name" => $dbProduct['product_name'],
                        "variant" => $dbProduct['variant'] ?? 'No Variant'
                    ];
                }
            }
        }

        return $resultPromotion;
    }
}
