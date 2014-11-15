DROP TABLE IF EXISTS `steelfig`.`wishlist_items` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`wishlist_items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `wishlist_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `barcode` VARCHAR(45) NULL,
  `url` VARCHAR(255) NULL,
  `price` INT UNSIGNED NULL,
  `is_purchased` BOOLEAN NOT NULL DEFAULT False,
  `sort` INT NULL DEFAULT 0,
  `comments` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_wishlist_items_wishlist_id` (`wishlist_id` ASC),
  CONSTRAINT `fk_wishlist_items_wishlists`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `steelfig`.`wishlists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
