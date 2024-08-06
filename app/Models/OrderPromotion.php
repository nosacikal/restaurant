<?php

namespace App\Models;

use CodeIgniter\Model;

class OrderPromotion extends Model
{
    protected $table            = 'tr_order_promotions';
    protected $primaryKey       = 'id_order_promotion';
    protected $useAutoIncrement = true;
    protected $allowedFields    = ['id_order', 'id_promotion', 'quantity'];
}
