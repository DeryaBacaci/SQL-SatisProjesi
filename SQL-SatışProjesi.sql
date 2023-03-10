USE [satisVT]
GO
/****** Object:  Table [dbo].[tblurunler]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblurunler](
	[urunıd] [int] IDENTITY(1,1) NOT NULL,
	[urunad] [varchar](50) NULL,
	[urunmarka] [varchar](50) NULL,
	[kategorı] [tinyint] NULL,
	[urunalısfıyat] [decimal](18, 2) NULL,
	[urunsatısfıyat] [decimal](18, 2) NULL,
	[urunstok] [smallint] NULL,
	[urundurum] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[urunıd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblpersonel]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpersonel](
	[personelıd] [smallint] IDENTITY(1,1) NOT NULL,
	[personeladsoyad] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[personelıd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblmusterı]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblmusterı](
	[musterııd] [int] IDENTITY(1,1) NOT NULL,
	[musterıad] [varchar](50) NULL,
	[musterısoyad] [varchar](50) NULL,
	[musterısehır] [varchar](13) NULL,
	[musterıbakıye] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[musterııd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblhareket]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblhareket](
	[hareketıd] [int] IDENTITY(1,1) NOT NULL,
	[urun] [int] NULL,
	[musterı] [int] NULL,
	[personel] [smallint] NULL,
	[adet] [int] NULL,
	[tutar] [decimal](18, 2) NULL,
	[tarıh] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[hareketıd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TEST1]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----veri tabanı açalım---
create database satisVT
-----tablo oluşturalım--
use satisvt
create table tblkategorı
(
kategorııd tinyint identity(1,1) primary key,
kategorıaadı varchar(50)
)
----------------yeni tablo
create table tblurunler
(
urunıd int identity(1,1) primary key,
urunadı varchar(50),
urunmarka varchar(50),
kategorı tinyint,
urunalısfıyat decimal(18,2),
urunsatısfıyat decimal(18,2),
urunstok smallint check(urunstok>0),
urundurum bit default '1'
)
--------------şimdi ürün girişi yap--------------------------
---------------------üçüncü tabloyu yapalım---
create table tblpersonel
(
personelıd smallint identity(1,1) primary key,
personeladsoyad varchar(50)
)
--------------------yeni tablo açalım----------------------
create table tblmusterı
(
musterııd int primary key identity(1,1),
musterıad varchar(50),
musterısoyad varchar(50),
musterısehır varchar(13),
musterıbakıye  decimal(18,2)
)
-------------------son bir tablo daha yapıyoruz
create table tblhareket
(
hareketıd int identity(1,1) primary key,
urun int,
musterı int,
personel smallint,
adet int,
tutar decimal(18,2),
tarıh smalldatetime
)
--------------urunler tablosunu sıfırlayalım--------------------
truncate table tblurunler
--------------database  ile ilişkilendirdik---------
--------------şimdi dml komutları yazalım---------------------------
insert into tblkategorı (kategorıadı)values('BİLGİSAYAR')
insert into tblkategorı (kategorıadı)values('BEYAZ EŞYA')
insert into tblkategorı (kategorıadı)values('KÜÇÜK EV ALETİ')
insert into tblkategorı (kategorıadı)values('TV')
-----------------------------------------------
insert into tblurunler(urunad,urunmarka,kategorı,urunalısfıyat,urunsatısfıyat,urunstok)values('BUZDOLABI','SIEMENS',2,4356,4588,10)
----------------------------------------
SELECT*FROM TBLURUNLER
update tblurunler set urunad='SU ISITICI' WHERE URUNAD='KETTLE'
----------------------
SELECT kategorıad,count(*) as 'TOPLAM ÜRÜN'  from tblurunler inner join tblkategorı 
on tblurunler.kategorı=tblkategorı.kategorııd group by kategorıad order by count(*)
----------------------------
--kategori adı bilgisayar olan ürünlere 500tl zam yapalım :
1.yol:
update tblurunler set urunsatısfıyat +=500 where kategorıd=1
2.yol
update tblurunler set urunsatısfıyat +=500 where kategorı=(select kategorııd from tblkategorı where kategorıad='bilgisayar')
-------------------------------
ödev:TV KATEGORİSİNDE YÜZDE 10 İNDİRİM?
UPDATE TBLURUNLER set urunsatısfıyat=urunsatısfıyat*(0.9) where kategorı=(select kategorııd from tblkategorı where kategorıad='tv')
-----------------------------------
select count(*) as 'KAÇ FARKLI ÜRÜNÜM VAR',SUM(URUNSTOK) AS 'TOPLAM STOK SAYISI' from tblurunler
-----------------------------
ÖDEV: BEN STOĞUMDAKİ BÜTÜN ÜRÜNLERİ SATARSAM NE KADAR PARA KAZANIRIM?
select sum( urunstok*urunsatısfıyat) from tblurunler
-------------------------------------------
buz dolabından ne kadar kar elde ettik?
select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,
u(runsatısfıyat-urunalısfıyat) as 'KAR'
from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
----------------------------
--toplam kar?
select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,urunstok,
u(runsatısfıyat-urunalısfıyat) as 'KAR',
u(runsatısfıyat-urunalısfıyat)*urunstok as 'TOPLAM KAR'
from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
-----------------------------------------------
--ödev: TOPLAM KARI 1000 TL ALTINDA KALAN ÜRÜNLERİN SATIS FİYATINA YÜZDE YÜRMİ ZAM?
---------------------------------------------------
CREATE PROCEDURE HAREKET
AS
select hareketıd,urunad,musterıad+' '+musterısoyad as 'AD SOYAD',
personeladsoyad,adet,tutar,tarıh
from tblhareket inner join tblurunler 
on tblhareket.urun=tblurunler.urunıd
inner join tblmusterı
on tblhareket.musterı=tblmusterı.musterııd
inner join tblpersonel
on tblhareket.personel=tblpersonel.personelıd
-------------------------------------------------------
execute hareket  --execute: presedur olarak kayıt ettığımız hareketleri,çagırmak için kullanırız.
-----------------------------------------------------,
yeni bir precedure oluşturup execle çagırıp sonra silelim :
create procedure deneme
as
select*from tblurunler where urunstok>10
-------
-deneme proc.oluşturduk exec.ile çagıralım
exec deneme
-----şimdi silelim:
drop procedure deneme
---------------------------------------------
şimdi prosedure güncelleyellim:alter komutu ile
ALTER PROCEDURE [dbo].[HAREKET]
AS
select hareketıd,urunad,left(musterıad,1)+'.'+musterısoyad as 'AD SOYAD',
personeladsoyad,adet,tutar,tarıh
from tblhareket inner join tblurunler 
on tblhareket.urun=tblurunler.urunıd
inner join tblmusterı
on tblhareket.musterı=tblmusterı.musterııd
inner join tblpersonel
on tblhareket.personel=tblpersonel.personelıd
---------------şimdi prosedure dışardan veri girişi ekleyelim,bunun için yeni bir procedure yapalım.
create procedure urungetır
as
select urunad,urunstok,urunmarka from tblurunler
---
exec urungetır
---procedure şart(where) yazalım,değişken tanımlayalım  :
alter procedure urungetır
@Deger varchar(50)='BUZDOLABI'
as
select urunad,urunstok,urunmarka from tblurunler
where urunad=@Deger
---------------
exec urungetır @deger='çamaşır makinası'
exec urungetır @deger='laptop'
---------------DATA SORGULARI----------------------
select*from tblhareket where datepart(day,tarıh) between 1 and 3 
---1 ve 3 ekimde ankaradan urun almış olan müşterileri listeleyelim?
select *from tblhareket where datepart(day,tarıh) between 1 and 3 and
musterı=(select musterııd from tblmusterı where musterısehır='ankara')
--------------------------------------------
select DATENAME(month,getdate()),datename(month,'2019.01.15')
select datename(day,getdate())
select datename(weekday,getdate())--bugün haftanın hangi günü
select datename(weekday,'2019.06.10')--tarihi ayın hangi günü
-----------DefDiff: iki tarih arasındaki farkı verir : -------------------
SELECT DATEDIFF(YEAR,'2010.10.25',GETDATE())
SELECT DATEDIFF(MONTH,'2010.06.14','2015.08.06')
SELECT DATEDIFF(DAY,TARIH,GETDATE()) FROM tblhareket where HAREKETID=1
--------------DATEADD : ödeme tarihine gün,ay veya yıl olarak ekleme yapabiliriz :--------------------------
SELECT DATEADD (YEAR,3,'2009-10-25')
select dateadd(day,45,getdate())
select dateadd(month,350,getdate())
--------------ALT SORGULARI TEKRAR EDELİM------------------------
-herbir üründen kaç adet satılmış?
select urunad ,count(*) as 'ÜRÜN AD' from tblhareket 
inner join tblurunler on tblhareket.urun=tblurunler.urunıd
group by urunad ORDER BY COUNT(*)
----------
ÜRÜNLER TABLOSU İÇERİSİNDE SADECE SATILAN BİLGİSAYARLARI GETİR?
select*from tblhareket where urun in(select urunıd from tblurunler where urunad='laptop')
urunden sonre = koymadık in koyduk çünkü: parantezin içinde birden fazla deger döndüğü için
------------------------
şehri adana olan müşterilerin harcamalarını bulalım?
select musterıad+' '+musterısoyad,urun,adet,tutar,urunad,musterısehır from tblhareket inner join tblmusterı
on tblhareket.musterı=tblmusterı.musterııd 
inner join tblurunler on tblurunler.urunıd=tblhareket.hareketıd
where musterı in(select musterııd from tblmusterı where musterısehır='adana')
------------------------------
-ödev :-Beyaz eşya kategorısınde harcama yapmış müşterileri sorgula?
------------------------------
beyaz eşya kategorisindeki harcamalar?(iç içe 3 sorgu yaptık)
select*from tblhareket where urun in(select urunıd from tblurunler where kategorı=(select kategorııd from tblkategorı where kategorıad='beyaz eşya'))
------------------------------
adanalı ve ankaralı müşterilere satılan toplam urunlerin fiyatı?
select sum(tutar) from tblhareket where musterı in(select musterııd from tblmusterı where musterısehır='adana' or musterısehır='ankara')
------------------------------
adanalı,bursa ve ankaralı müşterilere satılan toplam urunlerin fiyatı? or kulanmadan yaz in. ile yaz
select sum(tutar) from tblhareket where musterı in(select musterııd from tblmusterı where musterısehır in('adana','bursa','ankara'))
---------------------------------
---------satılan ürünün stoğunu azaltma-------
select*from tblhareket where  urun=1
update tblurunler set urunstok=urunstok-(select sum(adet) from tblhareket where urun=1) where urunıd=1
-------------KASA TABLOSU-------------------
CREATE TABLE tblKASA
(
TOPLAM decimal(18,2)
)
----
insert into tblkasa values(0)  --özellikle ıd yoksa valuesi yazmadan böylede halldebilirz
select*from tblkasa
update tblkasa set toplam=(select sum(tutar) from tblhareket)
-----------------TRİGGER---
CREATE TABLE TBLSAYAC
(
ISLEM int
)
insert into tblsayac values(0)
update tblsayac set ıslem=(select count(*) from tblhareket)
şimdi biz hareket tablosuna 1 veri girince sayac tablosu 1 artsın : BU YÜZDEN TETİKLEYİCİ OLUŞTURUCAZ
CREATE TRIGGER ISLEMARTIS
ON tblhareket    --(hangi dosyada çalışacağını yazıyoruz.)
after  insert     --(insertten sonra çalışsın dedik)
as
update tblsayac set ıslem=ıslem+1
------------------------------------
create table TBLTOPLAMKATEGORI
(
ADET tinyint 
)
şimdi kategori alanındaki toplam ketegorıyi bu tabloya yazdıralım?
update tbltoplamkategorı set adet=(select count(*)from tblkategorı)
--------------------------------
şimdi bir tetikleyici daha yazalım
CREATE TRIGGER  KATEGORIARTIS
ON TBLKATEGORI
AFTER INSERT
AS
UPDATE TBLTOPLAMKATEGORI SET ADET +=1
YANİ TBLKATEGORI OLAN HER BİR DEĞİŞİKLİĞİ TBLTOPLAMKATEGORİDE GÜNCELLE DEDİK
--------------------------------------------------------------
PEKİ BU SEFER ARTRAN DEĞİL AZALTAN BİR TETİKLEYİCİ HAZIRLAYALIM :
CREATE TRIGGER KATEGORIAZALIS
ON TBLKATEGORI
AFTER DELETE
AS
UPDATE TBLTOPLAMKATEGORI SET ADET -=1
-------------------VİEW---------------------------
CREATE  VIEW TEST1
AS
SELECT*FROM TBLKATEGORI
--------
SELECT*FROM TEST1
--------view üzerinde güncelleme yapalım :*/
CREATE VIEW [dbo].[TEST1]
AS
SELECT dbo.tblurunler.urunmarka AS Expr1, dbo.tblurunler.urunad AS Expr2, dbo.tblmusterı.musterısoyad, dbo.tblpersonel.personeladsoyad, dbo.tblhareket.adet, dbo.tblhareket.tutar
FROM     dbo.tblurunler INNER JOIN
                  dbo.tblhareket ON dbo.tblurunler.urunıd = dbo.tblhareket.urun INNER JOIN
                  dbo.tblpersonel ON dbo.tblhareket.personel = dbo.tblpersonel.personelıd INNER JOIN
                  dbo.tblmusterı ON dbo.tblhareket.musterı = dbo.tblmusterı.musterııd
GO
/****** Object:  Table [dbo].[tblKASA]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKASA](
	[TOPLAM] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblkategorı]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblkategorı](
	[kategorııd] [tinyint] IDENTITY(1,1) NOT NULL,
	[kategorıad] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[kategorııd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBLSAYAC]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLSAYAC](
	[ISLEM] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBLTOPLAMKATEGORI]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLTOPLAMKATEGORI](
	[ADET] [tinyint] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblhareket] ON 

INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (1, 1, 3, 1, 1, CAST(4588.00 AS Decimal(18, 2)), CAST(N'2019-10-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (2, 6, 3, 1, 1, CAST(3455.00 AS Decimal(18, 2)), CAST(N'2019-10-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (3, 10, 3, 1, 1, CAST(2453.00 AS Decimal(18, 2)), CAST(N'2019-10-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (7, 1, 4, 1, 1, CAST(4588.00 AS Decimal(18, 2)), CAST(N'2019-10-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (8, 7, 4, 1, 2, CAST(2000.00 AS Decimal(18, 2)), CAST(N'2019-10-01T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (9, 2, 2, 3, 1, CAST(3000.00 AS Decimal(18, 2)), CAST(N'2019-10-02T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (10, 3, 2, 3, 1, CAST(5500.00 AS Decimal(18, 2)), CAST(N'2019-10-02T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (11, 9, 2, 3, 1, CAST(35.00 AS Decimal(18, 2)), CAST(N'2019-10-03T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (12, 10, 2, 3, 1, CAST(2453.00 AS Decimal(18, 2)), CAST(N'2019-10-03T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (13, 2, 4, 1, 1, CAST(3000.00 AS Decimal(18, 2)), CAST(N'2019-10-04T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (14, 3, 4, 1, 1, CAST(5500.00 AS Decimal(18, 2)), CAST(N'2019-10-05T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (15, 9, 5, 2, 3, CAST(105.00 AS Decimal(18, 2)), CAST(N'2019-10-05T00:00:00' AS SmallDateTime))
INSERT [dbo].[tblhareket] ([hareketıd], [urun], [musterı], [personel], [adet], [tutar], [tarıh]) VALUES (16, 10, 4, 1, 1, CAST(2453.00 AS Decimal(18, 2)), CAST(N'2019-07-10T00:00:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[tblhareket] OFF
GO
INSERT [dbo].[tblKASA] ([TOPLAM]) VALUES (CAST(36677.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblkategorı] ON 

INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (1, N'BİLGİSAYAR')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (2, N'BEYAZ EŞYA')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (3, N'KÜÇÜK EV ALETİ')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (4, N'MOBİLYA')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (6, N'diğer')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (8, N'')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (9, N'')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (10, N'')
INSERT [dbo].[tblkategorı] ([kategorııd], [kategorıad]) VALUES (11, N'test')
SET IDENTITY_INSERT [dbo].[tblkategorı] OFF
GO
SET IDENTITY_INSERT [dbo].[tblmusterı] ON 

INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (1, N'VEYSEL', N'YILDIRIM', N'ADANA', CAST(18000.00 AS Decimal(18, 2)))
INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (2, N'EMEL', N'ÖZBEY', N'ANKARA', CAST(21000.00 AS Decimal(18, 2)))
INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (3, N'ASLI', N'YILDIRIM', N'BURSA', CAST(16000.00 AS Decimal(18, 2)))
INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (4, N'MEHMET', N'TUNCA', N'ADANA', CAST(8000.00 AS Decimal(18, 2)))
INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (5, N'AYŞEGÜL', N'ÖZ', N'İSTANBUL', CAST(2500.00 AS Decimal(18, 2)))
INSERT [dbo].[tblmusterı] ([musterııd], [musterıad], [musterısoyad], [musterısehır], [musterıbakıye]) VALUES (6, N'derya', N'bacacı', N'ardahan', CAST(500000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[tblmusterı] OFF
GO
SET IDENTITY_INSERT [dbo].[tblpersonel] ON 

INSERT [dbo].[tblpersonel] ([personelıd], [personeladsoyad]) VALUES (1, N'ALİ ÇINAR')
INSERT [dbo].[tblpersonel] ([personelıd], [personeladsoyad]) VALUES (2, N'MURAT YILMAZ')
INSERT [dbo].[tblpersonel] ([personelıd], [personeladsoyad]) VALUES (3, N'AYŞE ÖZTÜRK')
SET IDENTITY_INSERT [dbo].[tblpersonel] OFF
GO
INSERT [dbo].[TBLSAYAC] ([ISLEM]) VALUES (13)
GO
INSERT [dbo].[TBLTOPLAMKATEGORI] ([ADET]) VALUES (7)
GO
SET IDENTITY_INSERT [dbo].[tblurunler] ON 

INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (1, N'BUZDOLABI', N'SIEMENS', 2, CAST(4356.00 AS Decimal(18, 2)), CAST(5046.80 AS Decimal(18, 2)), 22, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (2, N'LCD', N'LG', 4, CAST(2356.00 AS Decimal(18, 2)), CAST(2970.00 AS Decimal(18, 2)), 17, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (3, N'LAPTOP', N'MONSTER', 1, CAST(4788.00 AS Decimal(18, 2)), CAST(6050.00 AS Decimal(18, 2)), 18, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (4, N'LAPTOP', N'LENOVO', 1, CAST(3384.00 AS Decimal(18, 2)), CAST(5115.00 AS Decimal(18, 2)), 18, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (5, N'BUZDOLABI', N'ARÇELİK', 2, CAST(3366.00 AS Decimal(18, 2)), CAST(3800.50 AS Decimal(18, 2)), 19, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (6, N'ÇAMAŞIR MAKİNASI', N'ARÇELİK', 2, CAST(1258.00 AS Decimal(18, 2)), CAST(1625.80 AS Decimal(18, 2)), 29, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (7, N'FIRIN', N'SIEMENS', 2, CAST(750.00 AS Decimal(18, 2)), CAST(1100.00 AS Decimal(18, 2)), 18, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (8, N'ÜTÜ', N'SIEMENS', 3, CAST(250.00 AS Decimal(18, 2)), CAST(352.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (9, N'SU ISITICI', N'ARÇELİK', 3, CAST(20.00 AS Decimal(18, 2)), CAST(38.50 AS Decimal(18, 2)), 26, 1)
INSERT [dbo].[tblurunler] ([urunıd], [urunad], [urunmarka], [kategorı], [urunalısfıyat], [urunsatısfıyat], [urunstok], [urundurum]) VALUES (10, N'BULAŞIK MAKİNESİ', N'BOSCH', 2, CAST(2236.00 AS Decimal(18, 2)), CAST(2698.30 AS Decimal(18, 2)), 16, 1)
SET IDENTITY_INSERT [dbo].[tblurunler] OFF
GO
ALTER TABLE [dbo].[tblurunler] ADD  DEFAULT ('1') FOR [urundurum]
GO
ALTER TABLE [dbo].[tblhareket]  WITH CHECK ADD  CONSTRAINT [FK_tblhareket_tblmusterı] FOREIGN KEY([musterı])
REFERENCES [dbo].[tblmusterı] ([musterııd])
GO
ALTER TABLE [dbo].[tblhareket] CHECK CONSTRAINT [FK_tblhareket_tblmusterı]
GO
ALTER TABLE [dbo].[tblhareket]  WITH CHECK ADD  CONSTRAINT [FK_tblhareket_tblpersonel] FOREIGN KEY([personel])
REFERENCES [dbo].[tblpersonel] ([personelıd])
GO
ALTER TABLE [dbo].[tblhareket] CHECK CONSTRAINT [FK_tblhareket_tblpersonel]
GO
ALTER TABLE [dbo].[tblhareket]  WITH CHECK ADD  CONSTRAINT [FK_tblhareket_tblurunler] FOREIGN KEY([urun])
REFERENCES [dbo].[tblurunler] ([urunıd])
GO
ALTER TABLE [dbo].[tblhareket] CHECK CONSTRAINT [FK_tblhareket_tblurunler]
GO
ALTER TABLE [dbo].[tblurunler]  WITH CHECK ADD  CONSTRAINT [FK_tblurunler_tblkategorı] FOREIGN KEY([kategorı])
REFERENCES [dbo].[tblkategorı] ([kategorııd])
GO
ALTER TABLE [dbo].[tblurunler] CHECK CONSTRAINT [FK_tblurunler_tblkategorı]
GO
ALTER TABLE [dbo].[tblurunler]  WITH CHECK ADD CHECK  (([urunstok]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[HAREKET]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------veri tabanı açalım---

--create database satisVT

-------tablo oluşturalım--

--use satisvt
--create table tblkategorı
--(
--kategorııd tinyint identity(1,1) primary key,
--kategorıaadı varchar(50)
--)

------------------yeni tablo
--create table tblurunler
--(
--urunıd int identity(1,1) primary key,
--urunadı varchar(50),
--urunmarka varchar(50),
--kategorı tinyint,
--urunalısfıyat decimal(18,2),
--urunsatısfıyat decimal(18,2),
--urunstok smallint check(urunstok>0),
--urundurum bit default '1'
--)
----------------şimdi ürün girişi yap--------------------------
-----------------------üçüncü tabloyu yapalım---

--create table tblpersonel
--(
--personelıd smallint identity(1,1) primary key,
--personeladsoyad varchar(50)
--)
----------------------yeni tablo açalım----------------------

--create table tblmusterı
--(
--musterııd int primary key identity(1,1),
--musterıad varchar(50),
--musterısoyad varchar(50),
--musterısehır varchar(13),
--musterıbakıye  decimal(18,2)
--)
---------------------son bir tablo daha yapıyoruz

--create table tblhareket
--(
--hareketıd int identity(1,1) primary key,
--urun int,
--musterı int,
--personel smallint,
--adet int,
--tutar decimal(18,2),
--tarıh smalldatetime
--)
----------------urunler tablosunu sıfırlayalım--------------------
--truncate table tblurunler
----------------database  ile ilişkilendirdik---------
----------------şimdi dml komutları yazalım---------------------------

--insert into tblkategorı (kategorıadı)values('BİLGİSAYAR')
--insert into tblkategorı (kategorıadı)values('BEYAZ EŞYA')
--insert into tblkategorı (kategorıadı)values('KÜÇÜK EV ALETİ')
--insert into tblkategorı (kategorıadı)values('TV')
-------------------------------------------------

--insert into tblurunler(urunad,urunmarka,kategorı,urunalısfıyat,urunsatısfıyat,urunstok)values('BUZDOLABI','SIEMENS',2,4356,4588,10)
------------------------------------------
--SELECT*FROM TBLURUNLER
--update tblurunler set urunad='SU ISITICI' WHERE URUNAD='KETTLE'
------------------------
--SELECT kategorıad,count(*) as 'TOPLAM ÜRÜN'  from tblurunler inner join tblkategorı 
--on tblurunler.kategorı=tblkategorı.kategorııd group by kategorıad order by count(*)
------------------------------
----kategori adı bilgisayar olan ürünlere 500tl zam yapalım :
--1.yol:
--update tblurunler set urunsatısfıyat +=500 where kategorıd=1

--2.yol
--update tblurunler set urunsatısfıyat +=500 where kategorı=(select kategorııd from tblkategorı where kategorıad='bilgisayar')
---------------------------------
--ödev:TV KATEGORİSİNDE YÜZDE 10 İNDİRİM?

--UPDATE TBLURUNLER set urunsatısfıyat=urunsatısfıyat*(0.9) where kategorı=(select kategorııd from tblkategorı where kategorıad='tv')
-------------------------------------
--select count(*) as 'KAÇ FARKLI ÜRÜNÜM VAR',SUM(URUNSTOK) AS 'TOPLAM STOK SAYISI' from tblurunler
-------------------------------
--ÖDEV: BEN STOĞUMDAKİ BÜTÜN ÜRÜNLERİ SATARSAM NE KADAR PARA KAZANIRIM?

--select sum( urunstok*urunsatısfıyat) from tblurunler
---------------------------------------------
--buz dolabından ne kadar kar elde ettik?

--select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,
--(urunsatısfıyat-urunalısfıyat) as 'KAR'
--from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
------------------------------
----toplam kar?

--select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,urunstok,
--(urunsatısfıyat-urunalısfıyat) as 'KAR',
--(urunsatısfıyat-urunalısfıyat)*urunstok as 'TOPLAM KAR'
--from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
-------------------------------------------------
----ödev: TOPLAM KARI 1000 TL ALTINDA KALAN ÜRÜNLERİN SATIS FİYATINA YÜZDE YÜRMİ ZAM?
-----------------------------------------------------
--CREATE PROCEDURE HAREKET
--AS
--select hareketıd,urunad,musterıad+' '+musterısoyad as 'AD SOYAD',
--personeladsoyad,adet,tutar,tarıh
--from tblhareket inner join tblurunler 
--on tblhareket.urun=tblurunler.urunıd
--inner join tblmusterı
--on tblhareket.musterı=tblmusterı.musterııd
--inner join tblpersonel
--on tblhareket.personel=tblpersonel.personelıd
---------------------------------------------------------
--execute hareket  --execute: presedur olarak kayıt ettığımız hareketleri,çagırmak için kullanırız.

-------------------------------------------------------,
--yeni bir precedure oluşturup execle çagırıp sonra silelim :
--create procedure deneme
--as
--select*from tblurunler where urunstok>10
---------
---deneme proc.oluşturduk exec.ile çagıralım
--exec deneme
-------şimdi silelim:
--drop procedure deneme
-----------------------------------------------
--şimdi prosedure güncelleyellim:

CREATE PROCEDURE [dbo].[HAREKET]
AS
select hareketıd,urunad,left(musterıad,1)+'. '+musterısoyad as 'AD SOYAD',
personeladsoyad,adet,tutar,tarıh
from tblhareket inner join tblurunler 
on tblhareket.urun=tblurunler.urunıd
inner join tblmusterı
on tblhareket.musterı=tblmusterı.musterııd
inner join tblpersonel
on tblhareket.personel=tblpersonel.personelıd
GO
/****** Object:  StoredProcedure [dbo].[TEST4]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select*from products
--select*from products where categoryıd=(select categoryıd from categories 
--where categoryname='seafood') and UnitsInStock>50
--or supplierıd=(select supplierıd from suppliers where city='osaka'
-------------
--create procedure test1
--as
--select*from orders where EmployeeID  in(select employeeıd from employees where city='london')
--and shipvia=3 and shipcountry='france'
---------------------------
--exec test1
-------------
--create view VİEW1
--as
--select orderıd,companyname,Firstname+' '+lastname as 'EMPLOYEE',orderdate,shipname,shipcity,shipcountry from orders
--inner join customers on orders.customerıd=customers.customerıd
--inner join employees on orders.EmployeeID=Employees.EmployeeID
-----------------------
--SELECT*FROM VİEW1
------
--SELECT*FROM VİEW2--BUNU NEW VİEW TABLODAN YAPTIK
-------------------T_SQL :DEĞİŞKEN TÜRLERİ-------------------
--Declare @sayı int
--set @sayı=24
--select @sayı as 'Sonuç'
----------
--Declare @kisi1 varchar(20)
--set @kisi1 ='murat'
--select @kisi1
------------
--Declare @sayı1 int,@sayı2 int,@toplam int
--set @sayı1=20
--set @sayı2=30
--set @toplam=@sayı1+@sayı2
--select @toplam as'TOPLAM'
----------
--ÖDEV:3 SINAV NOTU GİRİLENN ÖĞRENCİNİN ORTALAMASINI ONDALIKLI OLARAK YAP?

--Declare @sınav1 int,@sınav2 int,@sınav3 int, @ortalama decimal(5,2)
--set @sınav1=40
--set @sınav2=80
--set @sınav3=97
--set @ortalama=(@sınav1+@sınav2+@sınav3)/3
--select @ortalama as 'ORTALAMA'
--------------
-----123=6 VEREN SORGUYU YAZALIM
--Declare @sayı int,@birler int,@onlar int,@yüzler int, @toplam int
--set @sayı=456
--set @birler=@sayı%10    -- 10 göre mod aldık
--set @onlar=(@sayı/10)%10
--set @yüzler=@sayı/100
--set @toplam=@birler+@onlar+@yüzler
--select @birler,@onlar,@yüzler,@toplam
-------------------------
--select*from tblmusterı

--declare @bakiye int
--set @bakiye=(select max(musterıbakıye) from tblmusterı)
--select @bakiye
-------------------------
--select*from tblurunler

--declare @stok int
--select @stok=max(urunstok)from tblurunler
--select*from tblurunler where urunstok=@stok
-----------------------
--select @@version
----------------
--print 'merhaba'
--declare @s1 int,@s2 int,@sonuc int
--set @s1=4
--set @s2=8
--set @sonuc=@s1*@s2
--print '4 ile 8 sayılarının çarpımı'
--print '**********************'
--print @sonuc
----------tablo tipi değişken :geçici tablo gibi düşünebiliriz-------------------
--declare @kisiler table
--(
--kisiıd int identity(1,1),
--kisiad varchar(50),
--kisisehir varchar(50)
--)
--insert into @kisiler (kisiad,kisisehir) values('ALİ','MALATYA')
--insert into @kisiler (kisiad,kisisehir) values('EMEL','TRABZON')
--select*from @kisiler where kisisehir like'%r%'
---------AKIŞ KONTROLLERİ---------
--if(10>5)
--print 'merhaba'
--else
--print 'selam'
----------------
--select*from tblurunler

--if(select sum(urunstok)from tblurunler)>100
--print 'toplam ürün sayısı 100den büyük'
--else
--print 'toplam ürün sayısı 100den küçük'
-------------------------------

--if(select count(*)from tblurunler)>20
--print '20den fazla çeşit ürün var'
--else
--print '20 den az çeşit ürün var'
-------------CASE: dallanmanın çok olduğu durumlarda kullanılan yapıdır--------------------

--select*from tblurunler

--select urunad,urunmarka,urundurum=
--case urundurum
--when  '1' then 'ÜRÜN VAR'
--when  '0' then 'ÜRÜN YOK'
--end
--from tblurunler
------------------------
--select urunad,urunmarka,kategorı=
--case kategorı
--when '1' then 'LAPTOP'
--when '2' then 'beyaz eşya'
--when '3' then 'küçük ev aleti'
--end
--from tblurunler
----------------------------
CREATE PROCEDURE [dbo].[TEST4]
AS
select urunad,urunmarka,urunstok=
case 
when urunstok>=1 and urunstok<=5 then 'kritik seviye'
when urunstok>=6 and urunstok<=10 then 'takviye yapılmalı'
when urunstok>10 then 'ürün stok sayısı yeterli'
end
from  tblurunler
-------------------------
GO
/****** Object:  StoredProcedure [dbo].[urungetır]    Script Date: 21.01.2023 23:04:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------veri tabanı açalım---

--create database satisVT

-------tablo oluşturalım--

--use satisvt
--create table tblkategorı
--(
--kategorııd tinyint identity(1,1) primary key,
--kategorıaadı varchar(50)
--)

------------------yeni tablo
--create table tblurunler
--(
--urunıd int identity(1,1) primary key,
--urunadı varchar(50),
--urunmarka varchar(50),
--kategorı tinyint,
--urunalısfıyat decimal(18,2),
--urunsatısfıyat decimal(18,2),
--urunstok smallint check(urunstok>0),
--urundurum bit default '1'
--)
----------------şimdi ürün girişi yap--------------------------
-----------------------üçüncü tabloyu yapalım---

--create table tblpersonel
--(
--personelıd smallint identity(1,1) primary key,
--personeladsoyad varchar(50)
--)
----------------------yeni tablo açalım----------------------

--create table tblmusterı
--(
--musterııd int primary key identity(1,1),
--musterıad varchar(50),
--musterısoyad varchar(50),
--musterısehır varchar(13),
--musterıbakıye  decimal(18,2)
--)
---------------------son bir tablo daha yapıyoruz

--create table tblhareket
--(
--hareketıd int identity(1,1) primary key,
--urun int,
--musterı int,
--personel smallint,
--adet int,
--tutar decimal(18,2),
--tarıh smalldatetime
--)
----------------urunler tablosunu sıfırlayalım--------------------
--truncate table tblurunler
----------------database  ile ilişkilendirdik---------
----------------şimdi dml komutları yazalım---------------------------

--insert into tblkategorı (kategorıadı)values('BİLGİSAYAR')
--insert into tblkategorı (kategorıadı)values('BEYAZ EŞYA')
--insert into tblkategorı (kategorıadı)values('KÜÇÜK EV ALETİ')
--insert into tblkategorı (kategorıadı)values('TV')
-------------------------------------------------

--insert into tblurunler(urunad,urunmarka,kategorı,urunalısfıyat,urunsatısfıyat,urunstok)values('BUZDOLABI','SIEMENS',2,4356,4588,10)
------------------------------------------
--SELECT*FROM TBLURUNLER
--update tblurunler set urunad='SU ISITICI' WHERE URUNAD='KETTLE'
------------------------
--SELECT kategorıad,count(*) as 'TOPLAM ÜRÜN'  from tblurunler inner join tblkategorı 
--on tblurunler.kategorı=tblkategorı.kategorııd group by kategorıad order by count(*)
------------------------------
----kategori adı bilgisayar olan ürünlere 500tl zam yapalım :
--1.yol:
--update tblurunler set urunsatısfıyat +=500 where kategorıd=1

--2.yol
--update tblurunler set urunsatısfıyat +=500 where kategorı=(select kategorııd from tblkategorı where kategorıad='bilgisayar')
---------------------------------
--ödev:TV KATEGORİSİNDE YÜZDE 10 İNDİRİM?

--UPDATE TBLURUNLER set urunsatısfıyat=urunsatısfıyat*(0.9) where kategorı=(select kategorııd from tblkategorı where kategorıad='tv')
-------------------------------------
--select count(*) as 'KAÇ FARKLI ÜRÜNÜM VAR',SUM(URUNSTOK) AS 'TOPLAM STOK SAYISI' from tblurunler
-------------------------------
--ÖDEV: BEN STOĞUMDAKİ BÜTÜN ÜRÜNLERİ SATARSAM NE KADAR PARA KAZANIRIM?

--select sum( urunstok*urunsatısfıyat) from tblurunler
---------------------------------------------
--buz dolabından ne kadar kar elde ettik?

--select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,
--(urunsatısfıyat-urunalısfıyat) as 'KAR'
--from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
------------------------------
----toplam kar?

--select urunıd,urunad,urunmarka,kategorıad,urunsatısfıyat,urunalısfıyat ,urunstok,
--(urunsatısfıyat-urunalısfıyat) as 'KAR',
--(urunsatısfıyat-urunalısfıyat)*urunstok as 'TOPLAM KAR'
--from tblurunler inner join tblkategorı on tblurunler.kategorı=tblkategorı.kategorııd
-------------------------------------------------
----ödev: TOPLAM KARI 1000 TL ALTINDA KALAN ÜRÜNLERİN SATIS FİYATINA YÜZDE YÜRMİ ZAM?
-----------------------------------------------------
--CREATE PROCEDURE HAREKET
--AS
--select hareketıd,urunad,musterıad+' '+musterısoyad as 'AD SOYAD',
--personeladsoyad,adet,tutar,tarıh
--from tblhareket inner join tblurunler 
--on tblhareket.urun=tblurunler.urunıd
--inner join tblmusterı
--on tblhareket.musterı=tblmusterı.musterııd
--inner join tblpersonel
--on tblhareket.personel=tblpersonel.personelıd
---------------------------------------------------------
--execute hareket  --execute: presedur olarak kayıt ettığımız hareketleri,çagırmak için kullanırız.

-------------------------------------------------------,
--yeni bir precedure oluşturup execle çagırıp sonra silelim :
--create procedure deneme
--as
--select*from tblurunler where urunstok>10
---------
---deneme proc.oluşturduk exec.ile çagıralım
--exec deneme
-------şimdi silelim:
--drop procedure deneme
-----------------------------------------------
--şimdi prosedure güncelleyellim:alter komutu ile

--ALTER PROCEDURE [dbo].[HAREKET]
--AS
--select hareketıd,urunad,left(musterıad,1)+'.'+musterısoyad as 'AD SOYAD',
--personeladsoyad,adet,tutar,tarıh
--from tblhareket inner join tblurunler 
--on tblhareket.urun=tblurunler.urunıd
--inner join tblmusterı
--on tblhareket.musterı=tblmusterı.musterııd
--inner join tblpersonel
--on tblhareket.personel=tblpersonel.personelıd
-----------------şimdi prosedure dışardan veri girişi ekleyelim,bunun için yeni bir procedure yapalım.
--create procedure urungetır
--as
--select urunad,urunstok,urunmarka from tblurunler
-----
--exec urungetır
-----procedure şart yazalım,değişken tanımlayalım  :
CREATE procedure [dbo].[urungetır]
@Deger varchar(50)='BUZDOLABI'
as
select urunad,urunstok,urunmarka from tblurunler
where urunad=@Deger
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[10] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblurunler"
            Begin Extent = 
               Top = 95
               Left = 2
               Bottom = 258
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblhareket"
            Begin Extent = 
               Top = 27
               Left = 221
               Bottom = 190
               Right = 415
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tblpersonel"
            Begin Extent = 
               Top = 179
               Left = 459
               Bottom = 355
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblmusterı"
            Begin Extent = 
               Top = 0
               Left = 461
               Bottom = 163
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1284
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TEST1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TEST1'
GO
