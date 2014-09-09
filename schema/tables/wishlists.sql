DROP TABLE IF EXISTS `steelfig`.`wishlists` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`wishlists` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `attendee_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `attendee_id`),
  INDEX `fk_wishlists_attendants_idx` (`attendee_id` ASC),
  CONSTRAINT `fk_wishlists_attendees`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `steelfig`.`attendees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
