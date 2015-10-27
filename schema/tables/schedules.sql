DROP TABLE IF EXISTS `steelfig`.`schedules` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`schedules` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT UNSIGNED NOT NULL,
  `attendee_id` INT UNSIGNED NOT NULL,
  `busy_at` DATETIME NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_schedules_attendee_idx` (`attendee_id` ASC),
  CONSTRAINT `fk_schedules_attendees`
    FOREIGN KEY (`attendee_id`)
    REFERENCES `steelfig`.`attendees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedules_events`
    FOREIGN KEY (`event_id`)
    REFERENCES `steelfig`.`events` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
