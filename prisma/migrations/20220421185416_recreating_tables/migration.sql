/*
  Warnings:

  - You are about to drop the column `created_at` on the `professionals` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `professionals` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `professionals` table. All the data in the column will be lost.
  - You are about to drop the column `comission` on the `provider_services` table. All the data in the column will be lost.
  - You are about to drop the column `professional_id` on the `provider_services` table. All the data in the column will be lost.
  - You are about to drop the column `standart_duration` on the `provider_services` table. All the data in the column will be lost.
  - You are about to drop the `clients` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `services` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `modified` to the `professionals` table without a default value. This is not possible if the table is not empty.
  - Added the required column `modified` to the `provider_services` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `provider_services` DROP FOREIGN KEY `provider_services_professional_id_fkey`;

-- DropForeignKey
ALTER TABLE `services` DROP FOREIGN KEY `services_client_id_fkey`;

-- DropForeignKey
ALTER TABLE `services` DROP FOREIGN KEY `services_professional_id_fkey`;

-- DropForeignKey
ALTER TABLE `services` DROP FOREIGN KEY `services_provider_service_id_fkey`;

-- DropIndex
DROP INDEX `professionals_username_key` ON `professionals`;

-- AlterTable
ALTER TABLE `professionals` DROP COLUMN `created_at`,
    DROP COLUMN `updated_at`,
    DROP COLUMN `username`,
    ADD COLUMN `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `modified` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `provider_services` DROP COLUMN `comission`,
    DROP COLUMN `professional_id`,
    DROP COLUMN `standart_duration`,
    ADD COLUMN `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `description` VARCHAR(191) NULL,
    ADD COLUMN `modified` DATETIME(3) NOT NULL;

-- DropTable
DROP TABLE `clients`;

-- DropTable
DROP TABLE `services`;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `users_username_key`(`username`),
    UNIQUE INDEX `users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users_professionals` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `professional_id` INTEGER NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `professionals_provider_services` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `available` BOOLEAN NOT NULL,
    `comission` DECIMAL(65, 30) NOT NULL,
    `default_duration_in_minutes` INTEGER NULL,
    `default_price` DECIMAL(65, 30) NULL,
    `provider_service_id` INTEGER NOT NULL,
    `professional_Id` INTEGER NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `provider_services_packages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `available` BOOLEAN NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `discount` DECIMAL(65, 30) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `professionals_provider_services_packages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `provider_services_packages` INTEGER NOT NULL,
    `professional_provider_service_id` INTEGER NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers_addresses` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NULL,
    `complement` VARCHAR(191) NULL,
    `neighborhood` VARCHAR(191) NULL,
    `city` VARCHAR(191) NOT NULL,
    `state` VARCHAR(191) NOT NULL,
    `zip_code` VARCHAR(191) NULL,
    `country` VARCHAR(191) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers_notes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `professional_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `cpf` VARCHAR(191) NULL,
    `phone_number` INTEGER NULL,
    `birth_date` DATETIME(3) NOT NULL,
    `instagram` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `customer_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users_professionals` ADD CONSTRAINT `users_professionals_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users_professionals` ADD CONSTRAINT `users_professionals_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `professionals_provider_services` ADD CONSTRAINT `professionals_provider_services_professional_Id_fkey` FOREIGN KEY (`professional_Id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `professionals_provider_services` ADD CONSTRAINT `professionals_provider_services_provider_service_id_fkey` FOREIGN KEY (`provider_service_id`) REFERENCES `provider_services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `professionals_provider_services_packages` ADD CONSTRAINT `professionals_provider_services_packages_professional_provi_fkey` FOREIGN KEY (`professional_provider_service_id`) REFERENCES `professionals_provider_services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `professionals_provider_services_packages` ADD CONSTRAINT `professionals_provider_services_packages_provider_services__fkey` FOREIGN KEY (`provider_services_packages`) REFERENCES `provider_services_packages`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_addresses` ADD CONSTRAINT `customers_addresses_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_notes` ADD CONSTRAINT `customers_notes_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_notes` ADD CONSTRAINT `customers_notes_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
