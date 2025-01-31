USE [master]
GO
/****** Object:  Database [unicat]    Script Date: 19-07-2024 00:50:40 ******/
CREATE DATABASE [unicat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'unicat', FILENAME = N'C:\Users\USER\unicat.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'unicat_log', FILENAME = N'C:\Users\USER\unicat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [unicat] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [unicat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [unicat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [unicat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [unicat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [unicat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [unicat] SET ARITHABORT OFF 
GO
ALTER DATABASE [unicat] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [unicat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [unicat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [unicat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [unicat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [unicat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [unicat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [unicat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [unicat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [unicat] SET  ENABLE_BROKER 
GO
ALTER DATABASE [unicat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [unicat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [unicat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [unicat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [unicat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [unicat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [unicat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [unicat] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [unicat] SET  MULTI_USER 
GO
ALTER DATABASE [unicat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [unicat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [unicat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [unicat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [unicat] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [unicat] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [unicat] SET QUERY_STORE = OFF
GO
USE [unicat]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 19-07-2024 00:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(200,1) NOT NULL,
	[CourseName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoursesDetails]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoursesDetails](
	[CoursesID] [int] IDENTITY(400,1) NOT NULL,
	[CourseImage] [varchar](100) NULL,
	[CourseName] [varchar](100) NULL,
	[CourseDesc] [varchar](100) NULL,
	[CourseTeacherName] [varchar](100) NULL,
	[CoursePrice] [decimal](10, 2) NULL,
	[StudentCount] [int] NULL,
	[rating] [int] NULL,
	[CourseID] [int] NULL,
	[SubCourseID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CoursesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseVideos]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseVideos](
	[VideoID] [int] IDENTITY(1,1) NOT NULL,
	[CoursesID] [int] NOT NULL,
	[VideoTitle] [nvarchar](100) NOT NULL,
	[VideoLink] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderid] [int] IDENTITY(500,1) NOT NULL,
	[UserID] [int] NULL,
	[amount] [decimal](8, 2) NULL,
	[CourseID] [int] NULL,
	[OrderDate] [date] NULL,
	[ExpiryDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCourse]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCourse](
	[SubCourseID] [int] IDENTITY(300,1) NOT NULL,
	[SubCourseName] [varchar](100) NULL,
	[CourseID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SubCourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[UserID] [int] IDENTITY(100,1) NOT NULL,
	[Username] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[password] [varchar](100) NULL,
	[Urole] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CoursesDetails] ADD  DEFAULT ((0)) FOR [StudentCount]
GO
ALTER TABLE [dbo].[CoursesDetails] ADD  DEFAULT ((0)) FOR [rating]
GO
ALTER TABLE [dbo].[CourseVideos]  WITH CHECK ADD  CONSTRAINT [FK_CourseVideos_CoursesDetails] FOREIGN KEY([CoursesID])
REFERENCES [dbo].[CoursesDetails] ([CoursesID])
GO
ALTER TABLE [dbo].[CourseVideos] CHECK CONSTRAINT [FK_CourseVideos_CoursesDetails]
GO
ALTER TABLE [dbo].[SubCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
/****** Object:  StoredProcedure [dbo].[AddCourse]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AddCourse] 
@CourseName varchar(100)
as 
begin
	Insert Course (CourseName) values (@CourseName);
end
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddUser] 
@username varchar(100),
@email varchar(100),
@password varchar(100),
@Urole varchar(100)
as 
begin
	Insert users (Username,Email,password,Urole) values (@username,@email,@password,@Urole)
end
GO
/****** Object:  StoredProcedure [dbo].[fetchUser]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[fetchUser]
as 
begin
	 select * from users

end
GO
/****** Object:  StoredProcedure [dbo].[selectuser]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[selectuser]
 @userid int
 as
 begin
	select * from users where UserID = @userid;
end
GO
/****** Object:  StoredProcedure [dbo].[StoreInOrders]    Script Date: 19-07-2024 00:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoreInOrders]
    @userid INT,
    @courseid INT,
    @amount DECIMAL(8,2),
    @orderDate DATE,
    @expiryDate DATE
AS
BEGIN
    INSERT INTO Orders (UserID, CourseID, amount, OrderDate, ExpiryDate)
    VALUES (@userid, @courseid, @amount, @orderDate, @expiryDate);

    SELECT SCOPE_IDENTITY();
END
GO
USE [master]
GO
ALTER DATABASE [unicat] SET  READ_WRITE 
GO
