<?php

namespace App\Validation;

class CustomRules
{
  public function validatePrice($value, string $params, array $data): bool
  {
    // Ensure the price is positive
    return $value > 0;
  }
}
