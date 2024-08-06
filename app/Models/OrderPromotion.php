<?php

namespace App\Models;

use CodeIgniter\Model;

class OrderPromotion extends Model
{
    protected $table            = 'tr_order_promotions';
    protected $primaryKey       = 'id_order_promotion';
    protected $useAutoIncrement = true;
    protected $allowedFields    = ['id_order', 'id_promotion', 'quantity'];

    public function getPromotionsByOrderId($orderId)
    {
        return $this
            ->join(
                'ref_promotions as promotions',
                'promotions.id_promotion = tr_order_promotions.id_promotion'
            )
            ->where('id_order', $orderId)->findAll();
    }

    public function getPromotionsProductByOrderId($orderId)
    {

        return $this
            ->join(
                'ref_promotions as promotions',
                'promotions.id_promotion = tr_order_promotions.id_promotion'
            )
            ->join(
                'ref_promotion_items as promotion_items',
                'promotion_items.id_promotion = promotions.id_promotion'
            )
            ->join(
                'ref_products as products',
                'products.id_product = promotion_items.id_product'
            )
            ->where('id_order', $orderId)->findAll();
    }
}
