//
//  AppDelegate.swift
//  PureGo
//
//  Created by admin on 6/4/24.
//

import UIKit
import CoreData
import CoreBluetooth
import AudioToolbox

var appDelegate_ = (UIApplication.shared.delegate) as! AppDelegate
struct Constants {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Global Variables
    var connectedDeviceActor: BLEActor?
    var centralManagerActor : CentralManagerActor!
    var deviceActors = [BLEActor]()
    var isReconnecting: Bool = false
    let navigationController : UINavigationController? = nil

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.centralManagerActor = CentralManagerActor.init(serviceUUIDs: [CBUUID.init(string: BLEConstants.kHARDWARE_KEY_SERVICE)])
        
//        self.centralManagerActor = CentralManagerActor.init(serviceUUIDs: []) // Scanning all devices
        self.addBleObserver()
        self.loadDeviceFromStorage()        
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PureGo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {
    func addBleObserver() {
        RegisterForNote(#selector(self.DeviceIsReady(_:)),kDeviceIsReady, self)
        RegisterForNote(#selector(self.DeviceDisconnected(_:)),kDeviceDisconnected, self)
    }
    
    @objc func DeviceIsReady(_ note: Notification) {
        printLog(titleString: "AppDelegate", messageString: "DeviceIsReady : note.object : \(String(describing: note.object))")
        guard let objActor = note.object as? BLEActor else {
            return
        }
        self.connectedDeviceActor = objActor
        self.isReconnecting = false
        DispatchQueue.main.async {
            print("hello")
        }
        //Send Command for authenticate device otherwise device will disconnect in 30 sec
        printLog(titleString: "AppDelegate", messageString: "DeviceIsReady : kCommand_Authentication")
    }
    
    @objc func DeviceDisconnected(_ note: Notification) {
    }
    
    //FETCH DEVICE ACTOR AND RECOONECT -----
    func loadDeviceFromStorage() {
        // Load the objects for default store
        let devices:NSArray = (LoadObjects(kDevicesStorageKey) as NSArray)
        // Make BLEActor object from state and sericemeta and command(plist files)
        for state in devices {
            let meta: String = kServiceMeta
            let commandMeta: String = kCommandMeta
            let deviceName: String = (devices[0] as! NSDictionary)["deviceName"] as! String
            let obj = state as! NSMutableDictionary
            self.deviceActors.append(BLEActor(deviceState: obj, servicesMeta: DictFromFile(meta), operationsMeta: DictFromFile(commandMeta), deviceName:obj["deviceName"] as? String ?? "unknow"))
        }
        
        if self.deviceActors.count > 0 {
            for connectedDevices in self.deviceActors {
                let deviceActor: BLEActor? = connectedDevices
                if deviceActor?.isConnected() == false {
                }
            }
        }
        printLog(titleString: "*********** AppDelegate", messageString: " *******loadDeviceFromStorage Count : \(self.deviceActors.count)")
    }
    
    func storeDeviceState() {
        if self.deviceActors.count > 0 {
            var states = [Any]()
            for deviceActor in self.deviceActors {
                states.append(deviceActor.state)
            }
            printLog(titleString: "AppDelegate", messageString: "storeDeviceState : states")
            StoreObjects(kDevicesStorageKey, states)
        } else {
            UserDefaults.standard.removeObject(forKey: kDevicesStorageKey)
            UserDefaults.standard.synchronize();
        }
    }
}

