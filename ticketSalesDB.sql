USE [master]
GO
/****** Object:  Database [TicketSales]    Script Date: 15.02.2021 23:05:49 ******/
CREATE DATABASE [TicketSales]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TicketSales', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TicketSales.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TicketSales_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TicketSales_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TicketSales] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TicketSales].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TicketSales] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TicketSales] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TicketSales] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TicketSales] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TicketSales] SET ARITHABORT OFF 
GO
ALTER DATABASE [TicketSales] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TicketSales] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TicketSales] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TicketSales] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TicketSales] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TicketSales] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TicketSales] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TicketSales] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TicketSales] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TicketSales] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TicketSales] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TicketSales] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TicketSales] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TicketSales] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TicketSales] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TicketSales] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TicketSales] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TicketSales] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TicketSales] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TicketSales] SET  MULTI_USER 
GO
ALTER DATABASE [TicketSales] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TicketSales] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TicketSales] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TicketSales] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TicketSales]
GO
/****** Object:  Table [dbo].[buses]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[buses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[plaque] [nchar](10) NOT NULL,
 CONSTRAINT [PK_buses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[expeditions]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[expeditions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bus_id] [int] NOT NULL,
	[route_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
	[price] [float] NOT NULL,
 CONSTRAINT [PK_expeditions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](20) NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[routes]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[routes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[departure] [nchar](20) NOT NULL,
	[arrival] [nchar](20) NULL,
 CONSTRAINT [PK_routes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tickets]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[expedition_id] [int] NOT NULL,
	[ticketPrice] [float] NOT NULL,
	[user_id] [int] NOT NULL,
	[seatNumber] [tinyint] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_tickets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[userRole]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRole](
	[userRole_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK_userRole] PRIMARY KEY CLUSTERED 
(
	[userRole_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 15.02.2021 23:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [nchar](20) NOT NULL,
	[user_surname] [nchar](20) NOT NULL,
	[email] [nchar](50) NOT NULL,
	[password] [nchar](10) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[buses] ON 

INSERT [dbo].[buses] ([id], [plaque]) VALUES (1, N'34SIY70   ')
INSERT [dbo].[buses] ([id], [plaque]) VALUES (2, N'34SLM34   ')
INSERT [dbo].[buses] ([id], [plaque]) VALUES (3, N'34SA34    ')
INSERT [dbo].[buses] ([id], [plaque]) VALUES (4, N'34AS34    ')
INSERT [dbo].[buses] ([id], [plaque]) VALUES (5, N'34ASA34   ')
SET IDENTITY_INSERT [dbo].[buses] OFF
SET IDENTITY_INSERT [dbo].[expeditions] ON 

INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (1, 1, 1, CAST(N'2021-02-13' AS Date), CAST(N'14:00:00' AS Time), 50)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (2, 2, 2, CAST(N'2021-02-15' AS Date), CAST(N'12:00:00' AS Time), 100)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (3, 2, 2, CAST(N'2021-02-16' AS Date), CAST(N'12:00:00' AS Time), 100)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (4, 2, 2, CAST(N'2021-02-17' AS Date), CAST(N'12:00:00' AS Time), 100)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (5, 3, 3, CAST(N'2021-02-15' AS Date), CAST(N'13:00:00' AS Time), 80)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (6, 3, 3, CAST(N'2021-02-17' AS Date), CAST(N'13:00:00' AS Time), 80)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (7, 3, 3, CAST(N'2021-02-16' AS Date), CAST(N'13:00:00' AS Time), 80)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (9, 4, 4, CAST(N'2021-02-15' AS Date), CAST(N'15:00:00' AS Time), 90)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (10, 4, 4, CAST(N'2021-02-16' AS Date), CAST(N'15:00:00' AS Time), 90)
INSERT [dbo].[expeditions] ([id], [bus_id], [route_id], [date], [time], [price]) VALUES (11, 4, 4, CAST(N'2021-02-17' AS Date), CAST(N'15:00:00' AS Time), 90)
SET IDENTITY_INSERT [dbo].[expeditions] OFF
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'yonetıcı            ')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'yolcu               ')
SET IDENTITY_INSERT [dbo].[roles] OFF
SET IDENTITY_INSERT [dbo].[routes] ON 

INSERT [dbo].[routes] ([id], [departure], [arrival]) VALUES (1, N'ELAZIĞ              ', N'İSTANBUL            ')
INSERT [dbo].[routes] ([id], [departure], [arrival]) VALUES (2, N'ANKARA              ', N'İSTANBUL            ')
INSERT [dbo].[routes] ([id], [departure], [arrival]) VALUES (3, N'BURSA               ', N'İSTANBUL            ')
INSERT [dbo].[routes] ([id], [departure], [arrival]) VALUES (4, N'DÜZCE               ', N'İSTANBUL            ')
SET IDENTITY_INSERT [dbo].[routes] OFF
SET IDENTITY_INSERT [dbo].[tickets] ON 

INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (1, 5, 80, 3, 1, 0)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (2, 5, 80, 3, 1, 0)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (3, 5, 80, 3, 1, 0)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (4, 5, 80, 3, 1, 0)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (5, 2, 100, 3, 1, 0)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (6, 5, 80, 3, 1, 1)
INSERT [dbo].[tickets] ([id], [expedition_id], [ticketPrice], [user_id], [seatNumber], [status]) VALUES (7, 7, 80, 3, 1, 1)
SET IDENTITY_INSERT [dbo].[tickets] OFF
SET IDENTITY_INSERT [dbo].[userRole] ON 

INSERT [dbo].[userRole] ([userRole_id], [user_id], [role_id]) VALUES (1, 1, 1)
INSERT [dbo].[userRole] ([userRole_id], [user_id], [role_id]) VALUES (2, 2, 2)
INSERT [dbo].[userRole] ([userRole_id], [user_id], [role_id]) VALUES (3, 3, 2)
INSERT [dbo].[userRole] ([userRole_id], [user_id], [role_id]) VALUES (4, 4, 1)
SET IDENTITY_INSERT [dbo].[userRole] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [user_name], [user_surname], [email], [password]) VALUES (1, N'osman               ', N'turgut              ', N'osmn23@gmail.com                                  ', N'1234      ')
INSERT [dbo].[users] ([id], [user_name], [user_surname], [email], [password]) VALUES (2, N'ömer                ', N'göktürk             ', N'omer@gmail.com                                    ', N'1234      ')
INSERT [dbo].[users] ([id], [user_name], [user_surname], [email], [password]) VALUES (3, N'osmn                ', N'trgt                ', N'osmn@gmail.com                                    ', N'1         ')
INSERT [dbo].[users] ([id], [user_name], [user_surname], [email], [password]) VALUES (4, N'admin               ', N'admin               ', N'admin@admin.com                                   ', N'admin     ')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[expeditions]  WITH CHECK ADD  CONSTRAINT [FK_expeditions_buses] FOREIGN KEY([bus_id])
REFERENCES [dbo].[buses] ([id])
GO
ALTER TABLE [dbo].[expeditions] CHECK CONSTRAINT [FK_expeditions_buses]
GO
ALTER TABLE [dbo].[expeditions]  WITH CHECK ADD  CONSTRAINT [FK_expeditions_routes] FOREIGN KEY([route_id])
REFERENCES [dbo].[routes] ([id])
GO
ALTER TABLE [dbo].[expeditions] CHECK CONSTRAINT [FK_expeditions_routes]
GO
ALTER TABLE [dbo].[tickets]  WITH CHECK ADD  CONSTRAINT [FK_tickets_expeditions] FOREIGN KEY([expedition_id])
REFERENCES [dbo].[expeditions] ([id])
GO
ALTER TABLE [dbo].[tickets] CHECK CONSTRAINT [FK_tickets_expeditions]
GO
ALTER TABLE [dbo].[tickets]  WITH CHECK ADD  CONSTRAINT [FK_tickets_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[tickets] CHECK CONSTRAINT [FK_tickets_users]
GO
ALTER TABLE [dbo].[userRole]  WITH CHECK ADD  CONSTRAINT [FK_userRole_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[userRole] CHECK CONSTRAINT [FK_userRole_roles]
GO
ALTER TABLE [dbo].[userRole]  WITH CHECK ADD  CONSTRAINT [FK_userRole_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[userRole] CHECK CONSTRAINT [FK_userRole_users]
GO
USE [master]
GO
ALTER DATABASE [TicketSales] SET  READ_WRITE 
GO
