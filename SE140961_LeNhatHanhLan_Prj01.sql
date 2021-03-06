USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 9/26/2021 12:04:10 PM ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [YellowMoonShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [YellowMoonShop] SET QUERY_STORE = OFF
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[userID] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[fullName] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[status] [bit] NULL,
	[roleID] [nvarchar](50) NULL,
 CONSTRAINT [PK_accounts] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[categoryID] [nvarchar](50) NOT NULL,
	[category] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderDetails]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetails](
	[detailID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [nvarchar](50) NULL,
	[productID] [nvarchar](50) NULL,
	[quantity] [int] NULL,
	[price] [int] NULL,
 CONSTRAINT [PK_orderDetails] PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[userID] [nvarchar](50) NULL,
	[orderDate] [datetime] NULL,
	[shippingAddress] [nvarchar](200) NULL,
	[totalPrice] [real] NULL,
	[paymentID] [nvarchar](50) NULL,
	[orderID] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[paymentStatus] [bit] NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[paymentID] [nvarchar](50) NOT NULL,
	[paymentName] [nvarchar](50) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_payments] PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[productID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[image] [nvarchar](200) NULL,
	[description] [nvarchar](500) NULL,
	[price] [real] NULL,
	[quantity] [int] NULL,
	[categoryID] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[createDate] [date] NULL,
	[expirationDate] [date] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[roleID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[updateRecord]    Script Date: 9/26/2021 12:04:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[updateRecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userID] [nvarchar](50) NULL,
	[productID] [nvarchar](50) NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_updateRecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[accounts] ([userID], [password], [fullName], [phone], [address], [status], [roleID]) VALUES (N'aaa', N'1', N'AAA', N'0111111111', N'a', 1, N'mem')
INSERT [dbo].[accounts] ([userID], [password], [fullName], [phone], [address], [status], [roleID]) VALUES (N'ad', N'1', N'ADM', N'0111111112', N'b', 1, N'ad')
INSERT [dbo].[accounts] ([userID], [password], [fullName], [phone], [address], [status], [roleID]) VALUES (N'bbb', N'123', N'BBB', N'0000011111', N'address', 1, N'mem')
INSERT [dbo].[accounts] ([userID], [password], [fullName], [phone], [address], [status], [roleID]) VALUES (N'ccc', N'123', N'CCC', N'3333333333', N'c/c/c', 1, N'mem')
GO
INSERT [dbo].[categories] ([categoryID], [category], [status], [description]) VALUES (N'a', N'Bánh ', 1, N'Phần vỏ bánh và phần nhân. Vỏ bánh được làm từ bột mì, bột nở, nước đường và dầu ăn. Phần nhân thập cẩm là sự kết hợp của một số loại nguyên liệu như của lạp xưởng, trần bì, các loại hạt, mứt bí, mỡ đường, hạt sen, mè, chà bông, gà')
INSERT [dbo].[categories] ([categoryID], [category], [status], [description]) VALUES (N'b', N'Sticky ', 1, N'Vỏ bánh dẻo làm từ bột nếp rang xay mịn nhào quyện cùng nước đường, nước hoa bưởi. Nhân bánh được làm từ đậu xanh được làm nhuyễn sên đặc')
INSERT [dbo].[categories] ([categoryID], [category], [status], [description]) VALUES (N'c', N'Speciality', 1, N'Bánh trung thu rau câu, tỏi đen, tiramisu...')
GO
SET IDENTITY_INSERT [dbo].[orderDetails] ON 

INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (4, N'1603064378622', N'cake 2', 2, 200)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (5, N'1603064378622', N'cake 3', 1, 150)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (6, N'1603065188918', N'cake 7', 2, 160)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (7, N'1603065270050', N'cake 4', 1, 200)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (8, N'1603069348551', N'cake 2', 1, 200)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (9, N'1603070046404', N'cake 3', 1, 150)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (10, N'1603122302792', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (11, N'1603122302792', N'cake 11', 1, 305)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (12, N'1603128527330', N'cake 10', 1, 300)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (13, N'1603128527330', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (14, N'1603128705949', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (15, N'1603199232365', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (19, N'1608126283242', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (20, N'1608131487365', N'cake 10', 2, 300)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (21, N'1608131487365', N'cake 11', 1, 305)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (22, N'1608494753583', N'cake 12', 2, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (23, N'1608494753583', N'cake 11', 1, 305)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (24, N'1608773871501', N'cake 10', 13, 300)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (25, N'1608773871501', N'cake 11', 1, 305)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (26, N'1608782891046', N'cake 1', 1, 100)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (27, N'1608782891046', N'cake 8', 3, 11)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (28, N'1608797177303', N'cake 1', 2, 100)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (29, N'1608797478753', N'cake 1', 1, 100)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (30, N'1608801803612', N'cake 1', 2, 100)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (31, N'1608858578530', N'cake 7', 25, 160)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (32, N'1608858578530', N'cake 8', 1, 99)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (33, N'1608858728600', N'cake 1', 96, 100)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (34, N'1608858728600', N'cake 5', 99, 110)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (35, N'1608860884049', N'cake 8', 7, 99)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (36, N'1631197199711', N'cake 6', 2, 160)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (37, N'1631197199711', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (38, N'1631197232429', N'cake 2', 1, 200)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (39, N'1631197232429', N'cake 12', 1, 350)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (40, N'1631197341642', N'cake 9', 1, 30)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (41, N'1631197341642', N'cake 11', 1, 305)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (42, N'1631197402333', N'cake 9', 2, 30)
INSERT [dbo].[orderDetails] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (43, N'1631220596368', N'cake 9', 3, 30)
SET IDENTITY_INSERT [dbo].[orderDetails] OFF
GO
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a/a/a', 550, N'COD', N'1603064378622', N'1111111111', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'b/b/b', 320, N'MM', N'1603065188918', N'2222222222', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'b/b/b', 200, N'MM', N'1603065270050', N'2222222222', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 200, N'PP', N'1603069348551', N'0111111111', N'AAA       ', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'ccc', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'c/c/c', 150, N'COD', N'1603070046404', N'3333333333', N'CCC       ', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a/a/a', 655, N'COD', N'1603122302792', N'1111111111', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a/a/a', 650, N'COD', N'1603128527330', N'1111111111', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'b/b/b', 350, N'MM', N'1603128705949', N'2222222222', NULL, 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 350, N'PP', N'1603199232365', N'0111111111', N'AAA       ', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'Abc', 350, N'COD', N'1608126283242', N'999999999999', N'A', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 905, N'COD', N'1608131487365', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'Saigon', 1005, N'COD', N'1608494753583', N'123456', N'CC', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 4205, N'COD', N'1608773871501', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'', 133, N'COD', N'1608782891046', N'', N'', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'aa', 200, N'COD', N'1608797177303', N'1234567890', N'f', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'aaaaaaaaaa', 100, N'COD', N'1608797478753', N'1234567890', N'a', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'sadfsadfsdf', 200, N'COD', N'1608801803612', N'1234567890', N'asdfsdf', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'1', 4099, N'COD', N'1608858578530', N'1111111111', N'a', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 20490, N'COD', N'1608858728600', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-19T00:00:00.000' AS DateTime), N'a', 693, N'COD', N'1608860884049', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-09T21:19:59.710' AS DateTime), N'aDSSAD', 670, N'COD', N'1631197199711', N'1234567890', N'AA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-09T21:20:32.430' AS DateTime), N'dd', 550, N'COD', N'1631197232429', N'1234567890', N'aa', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-09T21:22:21.643' AS DateTime), N'a', 335, N'COD', N'1631197341642', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (N'aaa', CAST(N'2021-09-09T21:23:22.333' AS DateTime), N'a', 60, N'COD', N'1631197402333', N'0111111111', N'AAA', 1)
INSERT [dbo].[orders] ([userID], [orderDate], [shippingAddress], [totalPrice], [paymentID], [orderID], [phone], [name], [paymentStatus]) VALUES (NULL, CAST(N'2021-09-10T03:49:56.367' AS DateTime), N'cy', 90, N'COD', N'1631220596368', N'1234567890', N'cy', 1)
GO
INSERT [dbo].[payments] ([paymentID], [paymentName], [status]) VALUES (N'COD', N'COD', NULL)
INSERT [dbo].[payments] ([paymentID], [paymentName], [status]) VALUES (N'MM', N'Momo Wallet', NULL)
INSERT [dbo].[payments] ([paymentID], [paymentName], [status]) VALUES (N'PP', N'Paypal', NULL)
GO
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 1', N'Chocolate Cake', N'img/1632410357305.png', N'choco', 100, 10, N'a', 1, CAST(N'2021-09-16' AS Date), CAST(N'2021-12-31' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 10', N'Moon Cake', N'img/1603133801552.jpg', N'Ngonnn', 100, 16, N'a', 1, CAST(N'2021-09-15' AS Date), CAST(N'2021-12-30' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 11', N'Moon Cake 2', N'img/1603119822653.jpg', N'', 305, 12, N'c', 1, CAST(N'2021-09-14' AS Date), CAST(N'2021-11-30' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 12', N'Moon Cake 3', N'img/1603119556656.jpg', N'', 350, 15, N'c', 1, CAST(N'2021-09-14' AS Date), CAST(N'2021-10-05' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 2', N'Matcha Cake', N'img/hello.jpg', N'matcha', 200, 44, N'b', 1, CAST(N'2021-09-14' AS Date), CAST(N'2021-11-12' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 3', N'Cheese', N'img/1603112561913.jpg', N'', 150, 21, N'c', 1, CAST(N'2021-09-10' AS Date), CAST(N'2021-11-12' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 4', N'Matcha Cake 2', N'img/1603112345242.jpg', N'matcha', 200, 49, N'b', 1, CAST(N'2021-09-09' AS Date), CAST(N'2021-11-12' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 5', N'Chocolate Cake 2', N'img/1632410616359.jpg', N'choco', 110, 13, N'a', 1, CAST(N'2021-09-11' AS Date), CAST(N'2021-11-12' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 6', N'Cheese Cake 2', N'img/1632410653468.jpg', N'cheese', 160, 28, N'a', 1, CAST(N'2021-09-12' AS Date), CAST(N'2021-09-23' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 7', N'Chocolate Cake 3', N'img/1603134047439.jpg', N'choco', 160, 15, N'a', 1, CAST(N'2021-09-13' AS Date), CAST(N'2021-09-23' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 8', N'Thap Cam', N'img/1632410544213.jpg', N'difficult to eat', 99, 15, N'a', 1, CAST(N'2021-09-13' AS Date), CAST(N'2021-11-10' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 9', N'White cake', N'img/1608826767937.jpg', N'Sweet and sweet', 30, 14, N'a', 1, CAST(N'2021-09-20' AS Date), CAST(N'2021-09-30' AS Date))
INSERT [dbo].[products] ([productID], [name], [image], [description], [price], [quantity], [categoryID], [status], [createDate], [expirationDate]) VALUES (N'cake 99', N'Cake SOul', N'img/1632405939271.png', N'aaaaa', 500, 40, N'a', 0, CAST(N'2021-09-23' AS Date), CAST(N'2021-09-30' AS Date))
GO
INSERT [dbo].[roles] ([roleID], [name]) VALUES (N'ad', N'admin')
INSERT [dbo].[roles] ([roleID], [name]) VALUES (N'mem', N'member')
GO
SET IDENTITY_INSERT [dbo].[updateRecord] ON 

INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (1, N'ad', N'cake 12', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (2, N'ad', N'cake 10', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (3, N'ad', N'cake 10', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (4, N'ad', N'cake 2', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (5, N'ad', N'cake 10', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (6, N'ad', N'cake 10', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (7, N'ad', N'cake 7', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (8, N'ad', N'cake 8', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (9, N'ad', N'cake 8', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (10, N'ad', N'cake 8', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (11, N'ad', N'cake 8', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (12, N'ad', N'cake 8', CAST(N'2021-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (13, N'ad', N'cake 10', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (14, N'ad', N'cake 99', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (15, N'ad', N'cake 1', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (16, N'ad', N'cake 8', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (17, N'ad', N'cake 5', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
INSERT [dbo].[updateRecord] ([id], [userID], [productID], [date]) VALUES (18, N'ad', N'cake 6', CAST(N'2021-09-23T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[updateRecord] OFF
GO
ALTER TABLE [dbo].[accounts]  WITH CHECK ADD  CONSTRAINT [FK_accounts_roles] FOREIGN KEY([roleID])
REFERENCES [dbo].[roles] ([roleID])
GO
ALTER TABLE [dbo].[accounts] CHECK CONSTRAINT [FK_accounts_roles]
GO
ALTER TABLE [dbo].[orderDetails]  WITH CHECK ADD  CONSTRAINT [FK_orderDetails_orders] FOREIGN KEY([orderID])
REFERENCES [dbo].[orders] ([orderID])
GO
ALTER TABLE [dbo].[orderDetails] CHECK CONSTRAINT [FK_orderDetails_orders]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_accounts] FOREIGN KEY([userID])
REFERENCES [dbo].[accounts] ([userID])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_accounts]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_payments] FOREIGN KEY([paymentID])
REFERENCES [dbo].[payments] ([paymentID])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_payments]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_categories] FOREIGN KEY([categoryID])
REFERENCES [dbo].[categories] ([categoryID])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_categories]
GO
ALTER TABLE [dbo].[updateRecord]  WITH CHECK ADD  CONSTRAINT [FK_updateRecord_accounts] FOREIGN KEY([userID])
REFERENCES [dbo].[accounts] ([userID])
GO
ALTER TABLE [dbo].[updateRecord] CHECK CONSTRAINT [FK_updateRecord_accounts]
GO
ALTER TABLE [dbo].[updateRecord]  WITH CHECK ADD  CONSTRAINT [FK_updateRecord_products] FOREIGN KEY([productID])
REFERENCES [dbo].[products] ([productID])
GO
ALTER TABLE [dbo].[updateRecord] CHECK CONSTRAINT [FK_updateRecord_products]
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
