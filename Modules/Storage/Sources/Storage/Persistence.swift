import CoreData

public struct PersistenceController {
  static let shared = PersistenceController()
  
  public let container: NSPersistentContainer
  
  public init(inMemory: Bool = false) {
    guard let modelURL = Bundle.module.url(forResource: "Muvi", withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: modelURL) else { fatalError("can't load model") }
    container = NSPersistentContainer(name: "Muvi", managedObjectModel: model)
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
