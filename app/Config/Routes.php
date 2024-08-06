<?php

use CodeIgniter\Router\RouteCollection;
use App\Controllers\ProductController;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

$routes->group('api', static function (RouteCollection $routes): void {
  $routes->get('products', 'ProductController::index');

  // Order
  $routes->post('orders/create', 'OrderController::create');
});
