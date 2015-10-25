DROP TABLE IF EXISTS `steelfig`.`wishlists` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`wishlists` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `attendee_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NULL,
  `price` INT UNSIGNED NULL,
  `is_purchased` BOOLEAN NOT NULL DEFAULT False,
  `sort` INT NULL DEFAULT 0,
  `comments` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_wishlist_items_attendee_id` (`attendee_id` ASC),
  CONSTRAINT `fk_wishlist_items_attendees`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `steelfig`.`attendees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
