DROP TABLE IF EXISTS `steelfig`.`wishlist_categories` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`wishlist_categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `wishlist_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_wishlist_categories_wishlists_idx` (`wishlist_id` ASC),
  CONSTRAINT `fk_wishlist_categories_wishlists`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `steelfig`.`wishlists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
