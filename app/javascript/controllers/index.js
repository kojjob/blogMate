import { application } from "controllers/application"

// Import and register all your controllers from the importmap under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Manually register your custom controllers
// import FlashController from "./flash_controller"
// application.register("flash", FlashController)

// import DropdownController from "./dropdown_controller"
// application.register("dropdown", DropdownController)