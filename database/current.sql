USE [master]
GO
/****** Object:  Database [NYCBikes_dwh]    Script Date: 11.06.2023 17:43:45 ******/
CREATE DATABASE [NYCBikes_dwh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NYCBikes_dwh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\NYCBikes_dwh.mdf' , SIZE = 532480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NYCBikes_dwh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\NYCBikes_dwh_log.ldf' , SIZE = 3284992KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [NYCBikes_dwh] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NYCBikes_dwh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NYCBikes_dwh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET ARITHABORT OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NYCBikes_dwh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NYCBikes_dwh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NYCBikes_dwh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NYCBikes_dwh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET RECOVERY FULL 
GO
ALTER DATABASE [NYCBikes_dwh] SET  MULTI_USER 
GO
ALTER DATABASE [NYCBikes_dwh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NYCBikes_dwh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NYCBikes_dwh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NYCBikes_dwh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NYCBikes_dwh] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NYCBikes_dwh] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'NYCBikes_dwh', N'ON'
GO
ALTER DATABASE [NYCBikes_dwh] SET QUERY_STORE = ON
GO
ALTER DATABASE [NYCBikes_dwh] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [NYCBikes_dwh]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate](
	[DateKey] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[MonthName] [varchar](10) NULL,
	[Week] [smallint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[DayOfMonth] [smallint] NOT NULL,
	[DayOfWeek] [smallint] NOT NULL,
	[DayOfWeekName] [varchar](10) NULL,
	[IsWeekend] [bit] NULL,
	[IsHoliday] [bit] NULL,
	[HolidayName] [varchar](100) NULL,
	[QuarterNumber] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimStations]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimStations](
	[Name] [varchar](100) NOT NULL,
	[RegionID] [int] NOT NULL,
	[Longitude] [numeric](11, 3) NOT NULL,
	[Latitude] [numeric](11, 3) NOT NULL,
	[ElectricBikeSurchargeWaiverFlag] [bit] NOT NULL,
	[ExternalID] [char](36) NOT NULL,
	[Capacity] [smallint] NOT NULL,
	[StationType] [varchar](30) NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[KioskFlag] [bit] NOT NULL,
	[StationKey] [varchar](7) NOT NULL,
	[ValidFrom] [bigint] NOT NULL,
	[ValidTo] [bigint] NULL,
	[IsCurrent] [bit] NOT NULL,
	[SKID] [int] IDENTITY(1,1) NOT NULL,
	[StationID] [char](36) NOT NULL,
 CONSTRAINT [PK_DimStations_SKID] PRIMARY KEY CLUSTERED 
(
	[SKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimStationsUpdate]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimStationsUpdate](
	[Name] [varchar](100) NOT NULL,
	[RegionID] [int] NOT NULL,
	[Longitude] [numeric](11, 3) NOT NULL,
	[Latitude] [numeric](11, 3) NOT NULL,
	[ElectricBikeSurchargeWaiverFlag] [bit] NOT NULL,
	[ExternalID] [char](36) NOT NULL,
	[Capacity] [smallint] NOT NULL,
	[StationType] [varchar](30) NOT NULL,
	[RegionName] [varchar](50) NOT NULL,
	[KioskFlag] [bit] NOT NULL,
	[StationKey] [varchar](7) NOT NULL,
	[ValidFrom] [bigint] NOT NULL,
	[ValidTo] [bigint] NULL,
	[IsCurrent] [bit] NOT NULL,
	[StationID] [char](36) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimWeatherState]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimWeatherState](
	[WeatherKey] [bigint] IDENTITY(1,1) NOT NULL,
	[Temperature] [decimal](3, 1) NOT NULL,
	[Relativehumidity] [smallint] NOT NULL,
	[DewPoint] [decimal](3, 1) NOT NULL,
	[ApparentTemperature] [decimal](3, 1) NOT NULL,
	[Precipitation] [decimal](5, 1) NOT NULL,
	[RainFall] [decimal](5, 1) NOT NULL,
	[SnowFall] [decimal](5, 1) NOT NULL,
	[CloudCover] [smallint] NOT NULL,
	[WindSpeed] [decimal](5, 1) NOT NULL,
	[WindGusts] [decimal](5, 1) NOT NULL,
	[WindDirection] [smallint] NOT NULL,
	[WeatherCode] [smallint] NOT NULL,
	[WeatherCodeName] [varchar](200) NOT NULL,
	[WeatherCodeShort] [smallint] NULL,
	[WeatherCodeNameShort] [varchar](200) NOT NULL,
 CONSTRAINT [PK_DimWeather] PRIMARY KEY CLUSTERED 
(
	[WeatherKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactStationStatus]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactStationStatus](
	[StationStatusKey] [bigint] IDENTITY(1,1) NOT NULL,
	[StationKey] [int] NOT NULL,
	[DateKey] [bigint] NOT NULL,
	[ReportTime] [time](0) NOT NULL,
	[ReportDateTime] [datetime] NOT NULL,
	[HasAvailableKeysFlag] [bit] NOT NULL,
	[InstalledFlag] [bit] NOT NULL,
	[StationStatus] [varchar](30) NOT NULL,
	[ReturningFlag] [bit] NOT NULL,
	[ScootersAvailableNumber] [smallint] NOT NULL,
	[ScootersUnavailableNumber] [smallint] NOT NULL,
	[DocksAvailableNumber] [smallint] NOT NULL,
	[BikesDisabledNumber] [smallint] NOT NULL,
	[BikesAvailableNumber] [smallint] NOT NULL,
	[EbikesAvailableNumber] [smallint] NOT NULL,
	[RentingFlag] [bit] NOT NULL,
	[ValetStatus] [varchar](30) NOT NULL,
	[ValetBlockedDocksNumber] [smallint] NOT NULL,
	[ValetOffDockCount] [smallint] NOT NULL,
	[ValetOffDockCapacity] [smallint] NOT NULL,
	[WeatherKey] [bigint] NOT NULL,
 CONSTRAINT [PK_FactStationStatus] PRIMARY KEY CLUSTERED 
(
	[StationStatusKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactTrip]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactTrip](
	[TripKey] [bigint] IDENTITY(1,1) NOT NULL,
	[WeatherKey] [bigint] NOT NULL,
	[RideID] [char](16) NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[StartTime] [time](0) NOT NULL,
	[StartDateKey] [bigint] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[EndTime] [time](0) NOT NULL,
	[EndDateKey] [bigint] NOT NULL,
	[StartStationName] [varchar](100) NOT NULL,
	[StartStationKey] [int] NOT NULL,
	[EndStationName] [varchar](100) NOT NULL,
	[EndStationKey] [int] NOT NULL,
	[RiderType] [varchar](20) NOT NULL,
	[Duration] [int] NOT NULL,
	[Distance] [int] NOT NULL,
	[RideableTypeName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_FactTrip] PRIMARY KEY CLUSTERED 
(
	[TripKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactTripStaging]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactTripStaging](
	[WeatherKey] [bigint] NOT NULL,
	[RideID] [char](16) NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[StartTime] [time](0) NOT NULL,
	[StartDateKey] [bigint] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[EndTime] [time](0) NOT NULL,
	[EndDateKey] [bigint] NOT NULL,
	[StartStationName] [varchar](100) NOT NULL,
	[StartStationKey] [int] NOT NULL,
	[EndStationName] [varchar](100) NOT NULL,
	[EndStationKey] [int] NOT NULL,
	[RiderType] [varchar](20) NOT NULL,
	[Duration] [int] NOT NULL,
	[Distance] [int] NULL,
	[RideableTypeName] [varchar](20) NOT NULL,
	[Temperature] [decimal](3, 1) NOT NULL,
	[Relativehumidity] [smallint] NOT NULL,
	[DewPoint] [decimal](3, 1) NOT NULL,
	[ApparentTemperature] [decimal](3, 1) NOT NULL,
	[Precipitation] [decimal](5, 1) NOT NULL,
	[RainFall] [decimal](5, 1) NOT NULL,
	[SnowFall] [decimal](5, 1) NOT NULL,
	[CloudCover] [smallint] NOT NULL,
	[WindSpeed] [decimal](5, 1) NOT NULL,
	[WindGusts] [decimal](5, 1) NOT NULL,
	[WindDirection] [smallint] NOT NULL,
	[WeatherCode] [smallint] NOT NULL,
	[WeatherCodeName] [varchar](100) NOT NULL,
	[WeatherCodeShort] [smallint] NOT NULL,
	[WeatherCodeNameShort] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Holidays]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holidays](
	[MonthNumber] [int] NULL,
	[DayNumber] [int] NULL,
	[HolidayName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeatherCodes]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeatherCodes](
	[Code] [smallint] NOT NULL,
	[Definition] [varchar](200) NOT NULL,
	[Type] [varchar](200) NOT NULL,
 CONSTRAINT [PK_WeatherCodes] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeatherHistory]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeatherHistory](
	[Time] [datetime] NOT NULL,
	[Temperature] [decimal](3, 1) NOT NULL,
	[Relativehumidity] [smallint] NOT NULL,
	[DewPoint] [decimal](3, 1) NOT NULL,
	[ApparentTemperature] [decimal](3, 1) NOT NULL,
	[Precipitation] [decimal](5, 1) NOT NULL,
	[RainFall] [decimal](5, 1) NOT NULL,
	[SnowFall] [decimal](5, 1) NOT NULL,
	[CloudCover] [smallint] NOT NULL,
	[WindSpeed] [decimal](5, 1) NOT NULL,
	[WindGusts] [decimal](5, 1) NOT NULL,
	[WindDirection] [smallint] NOT NULL,
	[WeatherCode] [smallint] NOT NULL,
	[WeatherCodeName] [varchar](200) NOT NULL,
	[WeatherCodeNameShort] [varchar](200) NOT NULL,
	[WeatherKey] [bigint] NOT NULL,
 CONSTRAINT [PK_WeatherHistory] PRIMARY KEY CLUSTERED 
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeatherHistoryUnmatched]    Script Date: 11.06.2023 17:43:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeatherHistoryUnmatched](
	[Time] [datetime] NOT NULL,
	[Temperature] [decimal](3, 1) NOT NULL,
	[Relativehumidity] [smallint] NOT NULL,
	[DewPoint] [decimal](3, 1) NOT NULL,
	[ApparentTemperature] [decimal](3, 1) NOT NULL,
	[Precipitation] [decimal](5, 1) NOT NULL,
	[RainFall] [decimal](5, 1) NOT NULL,
	[SnowFall] [decimal](5, 1) NOT NULL,
	[CloudCover] [smallint] NOT NULL,
	[WindSpeed] [decimal](5, 1) NOT NULL,
	[WindGusts] [decimal](5, 1) NOT NULL,
	[WindDirection] [smallint] NOT NULL,
	[WeatherCode] [smallint] NOT NULL,
	[WeatherCodeName] [varchar](200) NOT NULL,
	[WeatherCodeNameShort] [varchar](200) NOT NULL,
 CONSTRAINT [PK_WeatherHistoryUnmatched] PRIMARY KEY CLUSTERED 
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimStations]  WITH CHECK ADD  CONSTRAINT [FK_DimStations_DimDate] FOREIGN KEY([ValidFrom])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[DimStations] CHECK CONSTRAINT [FK_DimStations_DimDate]
GO
ALTER TABLE [dbo].[DimStations]  WITH CHECK ADD  CONSTRAINT [FK_DimStations_DimDate1] FOREIGN KEY([ValidTo])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[DimStations] CHECK CONSTRAINT [FK_DimStations_DimDate1]
GO
ALTER TABLE [dbo].[FactStationStatus]  WITH CHECK ADD  CONSTRAINT [FK_FactStationStatus_DimDate] FOREIGN KEY([DateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactStationStatus] CHECK CONSTRAINT [FK_FactStationStatus_DimDate]
GO
ALTER TABLE [dbo].[FactStationStatus]  WITH CHECK ADD  CONSTRAINT [FK_FactStationStatus_DimStations] FOREIGN KEY([StationKey])
REFERENCES [dbo].[DimStations] ([SKID])
GO
ALTER TABLE [dbo].[FactStationStatus] CHECK CONSTRAINT [FK_FactStationStatus_DimStations]
GO
ALTER TABLE [dbo].[FactStationStatus]  WITH CHECK ADD  CONSTRAINT [FK_FactStationStatus_DimWeather] FOREIGN KEY([WeatherKey])
REFERENCES [dbo].[DimWeatherState] ([WeatherKey])
GO
ALTER TABLE [dbo].[FactStationStatus] CHECK CONSTRAINT [FK_FactStationStatus_DimWeather]
GO
ALTER TABLE [dbo].[FactTrip]  WITH CHECK ADD  CONSTRAINT [FK_FactTrip_DimDate] FOREIGN KEY([StartDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactTrip] CHECK CONSTRAINT [FK_FactTrip_DimDate]
GO
ALTER TABLE [dbo].[FactTrip]  WITH CHECK ADD  CONSTRAINT [FK_FactTrip_DimDate1] FOREIGN KEY([EndDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactTrip] CHECK CONSTRAINT [FK_FactTrip_DimDate1]
GO
ALTER TABLE [dbo].[FactTrip]  WITH CHECK ADD  CONSTRAINT [FK_FactTrip_DimStations] FOREIGN KEY([StartStationKey])
REFERENCES [dbo].[DimStations] ([SKID])
GO
ALTER TABLE [dbo].[FactTrip] CHECK CONSTRAINT [FK_FactTrip_DimStations]
GO
ALTER TABLE [dbo].[FactTrip]  WITH CHECK ADD  CONSTRAINT [FK_FactTrip_DimStations1] FOREIGN KEY([EndStationKey])
REFERENCES [dbo].[DimStations] ([SKID])
GO
ALTER TABLE [dbo].[FactTrip] CHECK CONSTRAINT [FK_FactTrip_DimStations1]
GO
ALTER TABLE [dbo].[FactTrip]  WITH CHECK ADD  CONSTRAINT [FK_FactTrip_DimWeather] FOREIGN KEY([WeatherKey])
REFERENCES [dbo].[DimWeatherState] ([WeatherKey])
GO
ALTER TABLE [dbo].[FactTrip] CHECK CONSTRAINT [FK_FactTrip_DimWeather]
GO
USE [master]
GO
ALTER DATABASE [NYCBikes_dwh] SET  READ_WRITE 
GO
