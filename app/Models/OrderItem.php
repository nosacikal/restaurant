<?php

namespace App\Models;

use CodeIgniter\Model;

class OrderItem extends Model
{
    protected $table            = 'tr_order_items';
    protected $primaryKey       = 'id_order_items';
    protected $useAutoIncrement = true;
    protected $allowedFields    = ['id_order', 'id_product', 'quantity'];

    public function getOrderItemsByOrderId($orderId)
    {
        return $this
            ->join(
                'ref_products as products',
                'products.id_product = tr_order_items.id_product'
            )->where('tr_order_items.id_order', $orderId)
            ->findAll();
    }
}
