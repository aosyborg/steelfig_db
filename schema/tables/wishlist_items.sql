DROP TABLE IF EXISTS `steelfig`.`wishlist_items` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`wishlist_items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `wishlist_category_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `barcode` VARCHAR(45) NULL,
  `url` VARCHAR(255) NULL,
  `price` INT UNSIGNED NULL,
  `sort` INT UNSIGNED NULL DEFAULT 0,
  `comments` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_wishlist_items_wishlist_categories_idx` (`wishlist_category_id` ASC),
  CONSTRAINT `fk_wishlist_items_wishlist_categories`
    FOREIGN KEY (`wishlist_category_id`)
    REFERENCES `steelfig`.`wishlist_categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
