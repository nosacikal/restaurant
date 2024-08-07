<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Category;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;

class CategoryController extends BaseController
{
    use ResponseTrait;

    public function __construct()
    {
        $this->categoryModel = new Category();
    }

    public function index()
    {
        $categories = $this->categoryModel->findAll();

        if (empty($categories)) {
            $payload = [
                'message' => 'No categories found',
            ];
            return $this->respond($payload, ResponseInterface::HTTP_NOT_FOUND);
        }

        $payload = [
            'message' => 'Categories retrieved successfully',
            'data' => $categories
        ];
        return $this->respond($payload, ResponseInterface::HTTP_OK);
    }
}
