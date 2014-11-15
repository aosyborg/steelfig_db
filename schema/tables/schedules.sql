DROP TABLE IF EXISTS `steelfig`.`schedules` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`schedules` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `attendee_id` INT UNSIGNED NOT NULL,
  `time` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_schedules_attendee_idx` (`attendee_id` ASC),
  CONSTRAINT `fk_schedules_attendee`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `steelfig`.`attendees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
