//
//  Commands.swift
//
//  Created by Bhavik Patel
//

import UIKit
//import BugfenderSDK
import CoreFoundation

/// Colstants list which are related to BLE Operations
struct BLEConstants {
    // Device Services UUID
    static let kHARDWARE_KEY_SERVICE = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kGenericAccessCommand = "0x1800"               // Generic Access Command

    
    static let kDeviceName = "deviceName"
    // BLE Lib Key
    static let kPropertyOperationWrite = "write"
    static let kPropertyOperationRead = "read"
    static let kPropertyOperationReadWait = "readWait"
    
    // Timeout Command
    static let kCommandPropertySetTimeout = 10.0
    static let kDisconnectTimeout = 10.0
    static let kLowPriorityTimeout = 2.0
    static let kCBPathDelimiter = "."
    
    static let kName = "name"
    static let kValues = "values"
    static let kTimeoutSettings = "TimeoutSettings"
    
    static let kRssi  = "rssi"
    static let kPeripheralUUIDKey       = "peripheralUUID"
    static let kIsDeviceRemoved         = "isDeviceRemoved"

    //commands meta ///////by meet
    static let kcommand_WriteCommand = "writeCommandBodyTemp"
    static let kBLEWriteCommand = "writeCommand"
    static let kBLEReadCommand = "readCommand"

}
/// List of Ble Commands
struct BleCommands {
    static let kwriteCommandBodyTemp = "writeCommandBodyTemp"
}

/// CommandIDs defined for Bluetooth Protocol
struct CommandID {
  
    static let tuoxing: [UInt8] = [0x54,0x75,0x6f,0x78,0x69,0x6e,0x67]
    static let deviceId: UInt8 = 0x01
    static let cmd_editName: UInt8 = 0x11
    static let cmd_readName: UInt8 = 0x10
    static let cmd_noError: UInt8 = 0x00
    static let strCmdEditName = "54756f78696e67011100"
    static let strCmdTempAndBattery = "54756f78696e6701500000e682"
    static let strCmdReadName = "54756f78696e67011000004b9f"
    static let strCmdReadHeatingStatus = "54756f78696e67016000004347"
    static let strCmdHeatingOn = "54756f78696e670161000101872e"
    static let strCmdHeatingOff = "54756f78696e670161000100A63e"
}

/// Response CommandIDs defined for Bluetooth Protocol
struct ResponseCommandID {
    static let cam_1_on_off: UInt8 = 0x32
    static let cam_2_on_off: UInt8 = 0x33
    static let cam_3_on_off: UInt8 = 0x34
    static let cam_4_on_off: UInt8 = 0x35
}

/// Charactiristics name
struct CharName {
    static let kChar_writeCommand = "writeCommand"
    static let kChar_readCommand = "readCommand"
}

/// Erro declaration when any intruption occured
public struct MyError: Error {
    let msg: String
}
func printLog(titleString : String? , messageString : String?) -> Void {
    if let titleValue = titleString , !titleValue.isEmpty {
        debugPrint("\(titleValue) : \(messageString ?? "")")
    } else {
        debugPrint("\(messageString ?? "")")
    }
}
