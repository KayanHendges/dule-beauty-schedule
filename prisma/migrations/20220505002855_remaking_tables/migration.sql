/*
  Warnings:

  - The primary key for the `customer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `customers_addresses` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `customers_notes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `professionals` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `provider_services` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `provider_services_packages` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `available` on the `provider_services_packages` table. All the data in the column will be lost.
  - You are about to drop the column `discount` on the `provider_services_packages` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `provider_services_packages` table. All the data in the column will be lost.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `users_professionals` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `professionals_provider_services` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `professionals_provider_services_packages` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `service_id` to the `provider_services_packages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `services_package_id` to the `provider_services_packages` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `customers_addresses` DROP FOREIGN KEY `customers_addresses_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `customers_notes` DROP FOREIGN KEY `customers_notes_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `customers_notes` DROP FOREIGN KEY `customers_notes_professional_id_fkey`;

-- DropForeignKey
ALTER TABLE `professionals_provider_services` DROP FOREIGN KEY `professionals_provider_services_professional_Id_fkey`;

-- DropForeignKey
ALTER TABLE `professionals_provider_services` DROP FOREIGN KEY `professionals_provider_services_provider_service_id_fkey`;

-- DropForeignKey
ALTER TABLE `professionals_provider_services_packages` DROP FOREIGN KEY `professionals_provider_services_packages_professional_provi_fkey`;

-- DropForeignKey
ALTER TABLE `professionals_provider_services_packages` DROP FOREIGN KEY `professionals_provider_services_packages_provider_services__fkey`;

-- DropForeignKey
ALTER TABLE `users_professionals` DROP FOREIGN KEY `users_professionals_professional_id_fkey`;

-- DropForeignKey
ALTER TABLE `users_professionals` DROP FOREIGN KEY `users_professionals_user_id_fkey`;

-- AlterTable
ALTER TABLE `customer` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `customers_addresses` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `customer_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `customers_notes` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `customer_id` VARCHAR(191) NOT NULL,
    MODIFY `professional_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `professionals` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `provider_services` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `provider_services_packages` DROP PRIMARY KEY,
    DROP COLUMN `available`,
    DROP COLUMN `discount`,
    DROP COLUMN `name`,
    ADD COLUMN `service_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `services_package_id` VARCHAR(191) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `users` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `users_professionals` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `user_id` VARCHAR(191) NOT NULL,
    MODIFY `professional_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `professionals_provider_services`;

-- DropTable
DROP TABLE `professionals_provider_services_packages`;

-- CreateTable
CREATE TABLE `services` (
    `id` VARCHAR(191) NOT NULL,
    `available` BOOLEAN NOT NULL,
    `comission` DECIMAL(65, 30) NOT NULL,
    `default_duration_in_minutes` INTEGER NULL,
    `default_price` DECIMAL(65, 30) NULL,
    `provider_service_id` VARCHAR(191) NOT NULL,
    `professional_Id` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `services_packages` (
    `id` VARCHAR(191) NOT NULL,
    `available` BOOLEAN NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `discount` DECIMAL(65, 30) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers_services` (
    `id` VARCHAR(191) NOT NULL,
    `customer_id` VARCHAR(191) NOT NULL,
    `service_id` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders` (
    `id` VARCHAR(191) NOT NULL,
    `customer_id` VARCHAR(191) NOT NULL,
    `closed` BOOLEAN NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders_customers_services` (
    `id` VARCHAR(191) NOT NULL,
    `order_id` VARCHAR(191) NOT NULL,
    `customer_service_id` VARCHAR(191) NOT NULL,
    `provider_service_package_id` VARCHAR(191) NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `orders_customers_services_customer_service_id_key`(`customer_service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users_professionals` ADD CONSTRAINT `users_professionals_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users_professionals` ADD CONSTRAINT `users_professionals_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services` ADD CONSTRAINT `services_professional_Id_fkey` FOREIGN KEY (`professional_Id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services` ADD CONSTRAINT `services_provider_service_id_fkey` FOREIGN KEY (`provider_service_id`) REFERENCES `provider_services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `provider_services_packages` ADD CONSTRAINT `provider_services_packages_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `provider_services_packages` ADD CONSTRAINT `provider_services_packages_services_package_id_fkey` FOREIGN KEY (`services_package_id`) REFERENCES `services_packages`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_addresses` ADD CONSTRAINT `customers_addresses_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_notes` ADD CONSTRAINT `customers_notes_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_notes` ADD CONSTRAINT `customers_notes_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_services` ADD CONSTRAINT `customers_services_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customers_services` ADD CONSTRAINT `customers_services_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders` ADD CONSTRAINT `orders_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_customers_services` ADD CONSTRAINT `orders_customers_services_provider_service_package_id_fkey` FOREIGN KEY (`provider_service_package_id`) REFERENCES `provider_services_packages`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_customers_services` ADD CONSTRAINT `orders_customers_services_customer_service_id_fkey` FOREIGN KEY (`customer_service_id`) REFERENCES `customers_services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_customers_services` ADD CONSTRAINT `orders_customers_services_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
