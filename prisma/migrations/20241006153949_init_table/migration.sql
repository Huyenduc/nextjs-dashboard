-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "TrangThai" AS ENUM ('DATHANHTOAN', 'CHUATHANHTOAN', 'QUAHAN');

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "so_dien_thoai" TEXT NOT NULL,
    "dien_chi" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "ngay_sinh" TIMESTAMP(3) NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "CCCD" TEXT,
    "url_image" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SinhVien" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "mssv" TEXT NOT NULL,
    "lop" TEXT NOT NULL,
    "khoa_vien" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SinhVien_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Nhanvien" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "chuc_vu" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Nhanvien_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Phong" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "ten_phong" TEXT NOT NULL,
    "gia_phong" INTEGER NOT NULL,
    "so_nguoi" INTEGER NOT NULL,
    "tinh_trang" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Phong_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HopDongThuePhong" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "sinh_vien_id" UUID NOT NULL,
    "phong_id" UUID NOT NULL,
    "so_tien_thue" INTEGER NOT NULL,
    "ngay_thue" TIMESTAMP(3) NOT NULL,
    "ngay_tra" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HopDongThuePhong_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_so_dien_thoai_key" ON "User"("so_dien_thoai");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_CCCD_key" ON "User"("CCCD");

-- CreateIndex
CREATE UNIQUE INDEX "SinhVien_user_id_key" ON "SinhVien"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "SinhVien_mssv_key" ON "SinhVien"("mssv");

-- CreateIndex
CREATE UNIQUE INDEX "Nhanvien_user_id_key" ON "Nhanvien"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "HopDongThuePhong_sinh_vien_id_phong_id_key" ON "HopDongThuePhong"("sinh_vien_id", "phong_id");

-- AddForeignKey
ALTER TABLE "SinhVien" ADD CONSTRAINT "SinhVien_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Nhanvien" ADD CONSTRAINT "Nhanvien_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HopDongThuePhong" ADD CONSTRAINT "HopDongThuePhong_sinh_vien_id_fkey" FOREIGN KEY ("sinh_vien_id") REFERENCES "SinhVien"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "HopDongThuePhong" ADD CONSTRAINT "HopDongThuePhong_phong_id_fkey" FOREIGN KEY ("phong_id") REFERENCES "Phong"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
