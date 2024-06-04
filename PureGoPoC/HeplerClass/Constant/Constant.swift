
import Foundation

struct ValidationMsgs {
    static let kFieldRequired = "This field is required"
    static let kTaskLimitError = "Can not enter more than 100 characters."
}

//MARK: - VIEW CONTROLLERS IDENTIFIERS -
struct ScreenNameIdentifiers {
    static let kScanVC = "VZBELScanVC"
    static let kHomeVC = "VZBELHomeVC"
    static let kDashboardVC = "VZBELDashboardVC"
    static let kTaskListVC = "VZBELTaskListVC"
    static let kCustomPopUPVC = "CustomePopupVC"
}

//MARK: - TABLEVIEW CELL IDENTIFIERS -
struct TableViewCellIdentifiers {
    static let kDeviceListTblViewCell = "DeviceListTblViewCell"
    static let kDashboardCell = "DashboardCell"
    static let kTaskListCell = "VZBELTaskListCell"
    static let kAddtaskCell = "AddtaskCell"
}

struct UserDefaultsKeys {
    static let UserId = "UserId"
    static let arrayTimerModel = "arrayTimerModel"
    static let arrayTempModel = "arrayTempModel"
    static let selectedTimerModel = "selectedTimerModel"
    static let selectedTempModel = "selectedTempModel"
    static let isDarkMode = "isDarkMode"
    static let asPerDevice = "asPerDevice"
    static let communicationDate = "communicationDate"
    static let language = "language"
    static let ListDevice = "ListDevice"
    static let WorkingTime = "WorkingTime"
    static let PauseTime = "PauseTime"
    static let Temprature = "Temprature"
    static let Language = "Language"
}

struct StringFile{
    static let settings  = "Settings";
    static let dark_mode = "Dark Mode";
}

////MARK:- BLE CONTSTANTS -
let kPlease_enable_bluetooth = "Please enable bluetooth"
let kError = "Error"
let kConnected = "Connected"
let kDisconnected = "Disconnected"

struct BleConstants {
    static let kScaniingErrorMSg = "Application is searching for nearby Bluetooth Devices. Please make sure your device is turn on."
    static let kNearbyBluetoothDevices = "There is no connected device.Please Press below button for connect device."
    static let kVZBELWantsToTurnOnBluetooth = "VZBEL wants to turn on Bluetooth"
    static let kPleaseTurnOnBluetooth = "Please turn on Bluetooth to search VZBEL device."
    static let kGrantBluetooth = "Please grant bluetooth access in app settings"
    static let kOpenAppOrSystemSettingsAlertForFind = "Allow VZBEL to find, connect to, and determine the relative position of nearby devices?"
    static let kOpenAppOrSystemSettingsAlertForSelect = "Please select ALLOW ALWAYS to grant full location access to Quickserve works properly"
    
}

//MARK:- IMAGE CONSTATNS -
struct ImageIdentifiers {
    static let kBackIcon = "iv_back"
    static let kMenuIcon = "Menu Icon"
    static let kBluetoothAnimation = "bluetooth animation"
    static let kNetwork_bar1 = "Network4"
    static let kNetwork_bar2 = "Network3"
    static let kNetwork_bar3 = "Network2"
    static let kNetwork_bar4 = "Network1"
    static let kSelectedRedioButton = "SelectedRedioButton"
    static let kUnChaeckedRedioButton = "unChaeckedRedioButton"
    static let kRedRedioButton = "redRedioButton"
    static let kYellowRedioButton = "yellowRedioButton"
    static let kGreenRediButton = "greenRediButton"
}

struct TextIdentifiers {
    static let kScanning = "Scanning"
    static let kScanningDevices = "Scanning Devices"
    static let kDevices = "Devices"
    static let kNearbyAvailableDevices = "Nearby Available Devices"
    static let kConnectedDevices = "Connected Devices"
    static let kTypeHere = "Type here..."
    static let kUpdate = "Update"
    static let kHigh = "High"
    static let kModerate = "Moderate"
    static let kLow = "Low"
    
    //Toast Messages
    static let kTaskSavedSuccessfully = "Task saved successfully"
    static let kTaskSentSuccessfully = "Task sent successfully"
    static let kDeviceNotInRange = "Device not in range."
    static let kDeviceDisconnect = "Device Disconnect"
}

struct FontUtilites {
    static let kMedium = "AirbnbCereal-Medium"
}

struct ColorCode {
    static let kLightGray = "F4F4F4"
    static let kAddTaskListButton = "2E4156"
    static let kCellBackGround = "1C1C1C"
    static let kButtonBackground = "6E8DAF"
    
    static let kRedDarkMode = "80ED0606"
    static let kYellowDarkMod = "80F9D100"
    static let kGreenDarkMode = "8018B415"
    static let kRedLightMode = "ED0606"
    static let kYellowLightMode = "F9D100"
    static let kGreenLightMode = "18B415"
    static let kWhite = "FFFFFF"
    static let kLightModeTextColor = "6E8DAF"
    static let kDarkModeTextColor = "8BB0DA"
}

