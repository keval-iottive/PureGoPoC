
import UIKit
//import BugfenderSDK
import CoreBluetooth




class BlePeripharalModel: NSObject {
    @Published var id = UUID()
    public var peripharal : CBPeripheral!
    public var macAddress : String! = ""
    public var deviceName : String! = ""
    public var deviceImage : Data? = nil
    public var genericAccess: Int! = 0
    public var isConnectable : Bool! = false
    public var isDeviceProcessed : Bool! = false
    public var timestamp : Int! = 0
    public var arrRssi : [Double]! = []
    public var avgRSSI : Int! = -100
    public var isTrackingEnabled : Bool! = false

    init(_ id: UUID, _ peripharal : CBPeripheral? , _ macAddress : String , _ deviceName : String , _ deviceImage : Data?,  _ genericAccess : Int, _ isDeviceProcessed : Bool , _ isConnectable : Bool , _ timestamp : Int , _ arrRssi : [Double], _ avgRSSI : Int , _ isTrackingEnabled : Bool) {
        
        super.init()
        self.id = id
        self.peripharal = peripharal
        self.macAddress = macAddress
        self.deviceName = deviceName
        self.deviceImage = deviceImage
        self.genericAccess = genericAccess
        self.isConnectable = isConnectable
        self.isDeviceProcessed = isDeviceProcessed
        self.timestamp = timestamp
        self.arrRssi = arrRssi
        self.avgRSSI = avgRSSI
        self.isTrackingEnabled = isTrackingEnabled
    }
}
