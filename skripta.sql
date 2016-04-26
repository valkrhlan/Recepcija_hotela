-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tip_korisnika`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tip_korisnika` (
  `id_korisnika` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_korisnika`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`radnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`radnici` (
  `id_radnika` INT NOT NULL AUTO_INCREMENT,
  `korisnicko_ime` VARCHAR(45) NOT NULL,
  `lozinka` VARCHAR(45) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `kontakt` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tip_korisnika` INT NOT NULL,
  PRIMARY KEY (`id_radnika`),
  INDEX `fk_radnici_tip_korisnika_idx` (`tip_korisnika` ASC),
  CONSTRAINT `fk_radnici_tip_korisnika`
    FOREIGN KEY (`tip_korisnika`)
    REFERENCES `mydb`.`tip_korisnika` (`id_korisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kategorija_sobe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kategorija_sobe` (
  `id_kategorije` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `opis` TEXT(200) NOT NULL,
  PRIMARY KEY (`id_kategorije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sobe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sobe` (
  `id_sobe` INT NOT NULL AUTO_INCREMENT,
  `dostupnost` TINYINT(1) NOT NULL,
  `cijena` VARCHAR(45) NOT NULL,
  `id_kategorije` INT NOT NULL,
  PRIMARY KEY (`id_sobe`),
  INDEX `fk_sobe_kategorija_sobe1_idx` (`id_kategorije` ASC),
  CONSTRAINT `fk_sobe_kategorija_sobe1`
    FOREIGN KEY (`id_kategorije`)
    REFERENCES `mydb`.`kategorija_sobe` (`id_kategorije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`posjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`posjeta` (
  `id_posjeta` INT NOT NULL AUTO_INCREMENT,
  `platitelj` VARCHAR(45) NOT NULL,
  `broj_odraslih` INT NOT NULL,
  `broj_djece` INT NOT NULL,
  `kontakt` VARCHAR(45) NOT NULL,
  `trajanje` INT NOT NULL,
  PRIMARY KEY (`id_posjeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`racun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`racun` (
  `id_racuna` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `vrijeme` TIME NOT NULL,
  `iznos` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_racuna`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rezervacije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rezervacije` (
  `id_rezervacije` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `id_sobe` INT NOT NULL,
  `id_radnika` INT NOT NULL,
  `id_posjeta` INT NOT NULL,
  `id_racun` INT NULL,
  PRIMARY KEY (`id_rezervacije`),
  INDEX `fk_rezervacije_sobe1_idx` (`id_sobe` ASC),
  INDEX `fk_rezervacije_radnici1_idx` (`id_radnika` ASC),
  INDEX `fk_rezervacije_posjeta1_idx` (`id_posjeta` ASC),
  INDEX `fk_rezervacije_racun1_idx` (`id_racun` ASC),
  CONSTRAINT `fk_rezervacije_sobe1`
    FOREIGN KEY (`id_sobe`)
    REFERENCES `mydb`.`sobe` (`id_sobe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezervacije_radnici1`
    FOREIGN KEY (`id_radnika`)
    REFERENCES `mydb`.`radnici` (`id_radnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezervacije_posjeta1`
    FOREIGN KEY (`id_posjeta`)
    REFERENCES `mydb`.`posjeta` (`id_posjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezervacije_racun1`
    FOREIGN KEY (`id_racun`)
    REFERENCES `mydb`.`racun` (`id_racuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stanje_rezervacije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stanje_rezervacije` (
  `id_radnika` INT NOT NULL,
  `id_rezervacije` INT NOT NULL,
  `potvrda` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_radnika`, `id_rezervacije`, `potvrda`),
  INDEX `fk_radnici_has_rezervacije_rezervacije1_idx` (`id_rezervacije` ASC),
  INDEX `fk_radnici_has_rezervacije_radnici1_idx` (`id_radnika` ASC),
  CONSTRAINT `fk_radnici_has_rezervacije_radnici1`
    FOREIGN KEY (`id_radnika`)
    REFERENCES `mydb`.`radnici` (`id_radnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_radnici_has_rezervacije_rezervacije1`
    FOREIGN KEY (`id_rezervacije`)
    REFERENCES `mydb`.`rezervacije` (`id_rezervacije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`steta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`steta` (
  `id_stete` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `sankcija` DECIMAL(6,2) NOT NULL,
  `opis` TEXT(1000) NOT NULL,
  `podmireno` TINYINT(1) NOT NULL,
  `id_racuna` INT NOT NULL,
  PRIMARY KEY (`id_stete`),
  INDEX `fk_steta_racun1_idx` (`id_racuna` ASC),
  CONSTRAINT `fk_steta_racun1`
    FOREIGN KEY (`id_racuna`)
    REFERENCES `mydb`.`racun` (`id_racuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
