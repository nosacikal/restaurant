<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Product;
use App\Models\Promotion;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;

class MenuController extends BaseController
{
    protected $productModel;
    protected $promotionModel;

    use ResponseTrait;

    public function __construct()
    {
        $this->productModel = new Product();
        $this->promotionModel = new Promotion();
    }
    public function index()
    {
        $products = $this->productModel->getAllProduct();
        $promotions = $this->promotionModel->getAllPromotion();

        if (empty($products) && empty($promotions)) {
            $payload = [
                'message' => 'No menus found',
            ];
            return $this->respond($payload, ResponseInterface::HTTP_NOT_FOUND);
        }

        $menu = array_merge($products, $promotions);

        $payload = [
            'message' => 'Menu retrieved successfully',
            'data' => $menu
        ];
        return $this->respond($payload, ResponseInterface::HTTP_OK);
    }
}
