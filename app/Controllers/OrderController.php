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

            if ($this->orderModel->transStatus() === TRUE) {
                $this->orderModel->transRollback();
                throw new \Exception("Error transaction");
            }

            $this->orderModel->transCommit();
            return $this->respondCreated([
                'message' => 'Order created successfully',
                'data' => $orderId
            ]);
        } catch (\DatabaseException $e) {
            $this->orderModel->transRollback();
            return $this->fail($e->getMessage());
        } catch (\Exception $e) {
            $this->orderModel->transRollback();
            return $this->fail('An unexpected error occurred: ' . $e->getMessage());
        }
    }
}
