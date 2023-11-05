-- nomor 1

CREATE SCHEMA `kedai_kopi_nuri` ;

CREATE TABLE `kedai_kopi_nuri`.`customer` (
  `ID_customer` CHAR(6) NOT NULL,
  `Nama_customer` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_customer`));

CREATE TABLE `kedai_kopi_nuri`.`pegawai` (
  `NIK` CHAR(16) NOT NULL,
  `Nama_pegawai` VARCHAR(100) NOT NULL,
  `Jenis_kelamin` CHAR(1) NULL,
  `Email` VARCHAR(50) NULL,
  `Umur` INT NOT NULL,
  PRIMARY KEY (`NIK`));

CREATE TABLE `kedai_kopi_nuri`.`telepon` (
  `No_telp_pegawai` VARCHAR(15) NOT NULL,
  `Pegawai_NIK` CHAR(16) NOT NULL,
  PRIMARY KEY (`No_telp_pegawai`),
  constraint Pegawai_NIK foreign key (Pegawai_NIK)
        references pegawai(NIK)  
);

CREATE TABLE `kedai_kopi_nuri`.`menu_minuman` (
  `ID_minuman` CHAR(6) NOT NULL,
  `Nama_minuman` VARCHAR(50) NOT NULL,
  `Harga_minuman` FLOAT(2) NOT NULL,
  PRIMARY KEY (`ID_minuman`));

CREATE TABLE `kedai_kopi_nuri`.`transaksi` (
  `ID_transaksi` CHAR(10) NOT NULL,
  `Tanggal_transaksi` DATE NOT NULL,
  `Metode_pembayaran` VARCHAR(15) NOT NULL,
  `Customer_id_customer` CHAR(6) NOT NULL,
  `Pegawai_NIK` CHAR(16) NOT NULL,
  PRIMARY KEY (`ID_transaksi`),
CONSTRAINT `FK_Customer_id_customer` FOREIGN KEY (`Customer_id_customer`) REFERENCES customer(ID_customer),
CONSTRAINT `FK_Pegawai_NIK` FOREIGN KEY (`Pegawai_NIK`) REFERENCES pegawai(NIK)
);

CREATE TABLE `kedai_kopi_nuri`.`transaksi_minuman` (
  `TM_Menu_minuman_id` CHAR(6) NOT NULL,
  `TM_transaksi_id` CHAR(10) NOT NULL,
  `Jumlah_cup` INT NOT NULL,
  PRIMARY KEY (`TM_Menu_minuman_id`, `TM_transaksi_id`),
CONSTRAINT FK_TM_Menu_minuman_id FOREIGN KEY (TM_Menu_minuman_id) REFERENCES menu_minuman (ID_minuman),
CONSTRAINT FK_TM_transaksi_id FOREIGN KEY (TM_transaksi_id) REFERENCES transaksi (ID_transaksi)
);

-- nomor 2

CREATE TABLE `kedai_kopi_nuri`.`membership` (
  `id_membership` CHAR(6) NOT NULL,
  `no_telepon_customer` VARCHAR(15) NOT NULL,
  `alamat_customer` VARCHAR(100) NOT NULL,
  `tanggal_pembuatan_kartu_membership` DATE NOT NULL,
  `tanggal_kadaluarsa_kartu_membership` DATE NULL,
  `total_poin` INT NOT NULL,
  `customer_id_customer` CHAR(6) NOT NULL);

-- a-c
ALTER TABLE `kedai_kopi_nuri`.`membership` 
ADD PRIMARY KEY (`id_membership`),
ADD CONSTRAINT `customer_id_customer_fk` FOREIGN KEY (`customer_id_customer`) REFERENCES customer(`ID_customer`) ON DELETE CASCADE ON UPDATE CASCADE
;

-- d
ALTER TABLE `kedai_kopi_nuri`.`membership` 
CHANGE COLUMN `tanggal_pembuatan_kartu_membership` `tanggal_pembuatan_kartu_membership` DATE NOT NULL DEFAULT CURRENT_DATE
;

--e
ALTER TABLE `kedai_kopi_nuri`.`membership`
ADD CONSTRAINT CHK_minimum CHECK (total_poin>=0);

-- f
ALTER TABLE kedai_kopi_nuri.membership MODIFY COLUMN alamat_customer VARCHAR(100);

-- 3
  DROP TABLE kedai_kopi_nuri.telepon;
ALTER TABLE kedai_kopi_nuri.pegawai
ADD telepon varchar(15);

--4
INSERT INTO `kedai_kopi_nuri`.`customer` (`ID_customer`, `Nama_customer`) VALUES ('CTR001', 'Budi Santoso');
INSERT INTO `kedai_kopi_nuri`.`customer` (`ID_customer`, `Nama_customer`) VALUES ('CTR002', 'Sisil Triana');
INSERT INTO `kedai_kopi_nuri`.`customer` (`ID_customer`, `Nama_customer`) VALUES ('CTR003', 'Davi Liam');
INSERT INTO `kedai_kopi_nuri`.`customer` (`ID_customer`, `Nama_customer`) VALUES ('CTRo04', 'Sutris Ten An');
INSERT INTO `kedai_kopi_nuri`.`customer` (`ID_customer`, `Nama_customer`) VALUES ('CTR005', 'Hendra Asto');

INSERT INTO `kedai_kopi_nuri`.`membership` (`id_membership`, `no_telepon_customer`, `alamat_customer`, `tanggal_pembuatan_kartu_membership`, `tanggal_kadaluarsa_kartu_membership`, `total_poin`, `customer_id_customer`) VALUES ('MBR001', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', '0', 'CTR001');
INSERT INTO `kedai_kopi_nuri`.`membership` (`id_membership`, `no_telepon_customer`, `alamat_customer`, `tanggal_pembuatan_kartu_membership`, `tanggal_kadaluarsa_kartu_membership`, `total_poin`, `customer_id_customer`) VALUES ('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', '3', 'CTR002');
INSERT INTO `kedai_kopi_nuri`.`membership` (`id_membership`, `no_telepon_customer`, `alamat_customer`, `tanggal_pembuatan_kartu_membership`, `tanggal_kadaluarsa_kartu_membership`, `total_poin`, `customer_id_customer`) VALUES ('MBR003', '081234567890', 'Jl. Abah Ojak', '2023-10-25', '2023-12-1', '2', 'CTR003');
INSERT INTO `kedai_kopi_nuri`.`membership` (`id_membership`, `no_telepon_customer`, `alamat_customer`, `tanggal_pembuatan_kartu_membership`, `tanggal_kadaluarsa_kartu_membership`, `total_poin`, `customer_id_customer`) VALUES ('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-2', '6', 'CTR005');

INSERT INTO `kedai_kopi_nuri`.`pegawai` (`NIK`, `Nama_pegawai`, `Jenis_kelamin`, `Email`, `Umur`, `telepon`) VALUES ('1234567890123456', 'Naufal Raf', 'L', 'nuafal@gmail.com', '19', '62123456789');
INSERT INTO `kedai_kopi_nuri`.`pegawai` (`NIK`, `Nama_pegawai`, `Jenis_kelamin`, `Email`, `Umur`, `telepon`) VALUES ('2345678901234561', 'Surinala', 'P', 'surinala@gmail.com', '24', '621234567890');
INSERT INTO `kedai_kopi_nuri`.`pegawai` (`NIK`, `Nama_pegawai`, `Jenis_kelamin`, `Email`, `Umur`, `telepon`) VALUES ('3456789012345612', 'Ben Jhon', 'L', 'benjohn@gmail.com', '22', '6212345678');

INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000001', '2023-10-01', 'Kartu kredit', 'CTR002', '2345678901234561');
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000002', '2023-10-03', 'Transfer bank', 'CTRo04', '3456789012345612');
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000003', '2023-10-05', 'Tunai', 'CTR001', '3456789012345612');
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000004', '2023-10-15', 'Kartu debit', 'CTR003', '1234567890123456');
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000005', '2023-10-15', 'E-wallet', 'CTRo04', '1234567890123456');
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000006', '2023-10-21', 'Tunai', 'CTR001', '2345678901234561');

INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM001', 'Expresso', '18.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM002', 'Cappuccino', '20.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM003', 'Latte', '21.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM004', 'Americano', '19.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM005', 'Mocha', '22.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM006', 'Macchiato', '23.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM007', 'Cold Brew', '21.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM008', 'Iced Coffee', '18.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM009', 'Affogato', '23.000');
INSERT INTO `kedai_kopi_nuri`.`menu_minuman` (`ID_minuman`, `Nama_minuman`, `Harga_minuman`) VALUES ('MNM010', 'Coffee Frappe', '22.000');

INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM006', 'TRX0000005', '2');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM010', 'TRX0000001', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM005', 'TRX0000002', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM009', 'TRX0000005', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM001', 'TRX0000003', '3');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM003', 'TRX0000006', '2');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM004', 'TRX0000004', '2');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM010', 'TRX0000004', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM003', 'TRX0000002', '2');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM007', 'TRX0000001', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM001', 'TRX0000005', '1');
INSERT INTO `kedai_kopi_nuri`.`transaksi_minuman` (`TM_Menu_minuman_id`, `TM_transaksi_id`, `Jumlah_cup`) VALUES ('MNM003', 'TRX0000003', '1');

-- 5
INSERT INTO `kedai_kopi_nuri`.`transaksi` (`ID_transaksi`, `Tanggal_transaksi`, `Metode_pembayaran`, `Customer_id_customer`, `Pegawai_NIK`) VALUES ('TRX0000007', '2023-10-03', 'Transfer bank', 'CTR004', '2345678901234561');

-- 6
INSERT INTO `kedai_kopi_nuri`.`pegawai` (`NIK`, `Nama_pegawai`, `Umur`) VALUES ('1111222233334444', 'Maimunah', '25');

-- 7
alter table kedai_kopi_nuri.transaksi
drop foreign key FK_Customer_id_customer

alter table kedai_kopi_nuri.transaksi
ADD CONSTRAINT `FK_Customer_id_customer` FOREIGN KEY (`Customer_id_customer`) REFERENCES customer(ID_customer) on update cascade;

UPDATE kedai_kopi_nuri.customer
SET ID_customer = 'CTR004'
WHERE ID_customer = 'CTRo04';

-- 8
UPDATE `kedai_kopi_nuri`.`pegawai` SET `Jenis_kelamin` = 'P', `Email` = 'maimunah@gmail.com', `telepon` = '621234567' WHERE (`NIK` = '1111222233334444');

-- 9
UPDATE kedai_kopi_nuri.membership
SET total_poin = 0
WHERE tanggal_kadaluarsa_kartu_membership < '2023-12-01';

-- 10
DELETE FROM kedai_kopi_nuri.membership;

--11
DELETE FROM kedai_kopi_nuri.pegawai 
WHERE Nama_pegawai = 'Maimunah'