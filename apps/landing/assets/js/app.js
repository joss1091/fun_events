// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.

import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import jquery from "../vendor/js/jquery"
import "../vendor/js/bootstrap.bundle.min"
// import "../vendor/js/modernizr.custom"

import "../vendor/js/script"
window.jQuery = jquery;
window.$ = jquery;
import  Swal  from "../vendor/js/sweetlert2.min"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())


window.addEventListener("phx:popup-alert", ({detail}) => {
 
    if (detail.type == "success") {
        Swal.fire({
            icon: 'success',
            title: detail.text,
            showConfirmButton: false,
            timer: 1500
          })
    }
})

window.addEventListener("phx:copy", (event) => {
    let text = event.target.value; // Alternatively use an element or data tag!
      navigator.clipboard.writeText(text).then(() => {
        console.log("All done!"); // Or a nice tooltip or something.
      })
    })

// window.addEventListener('phoenix.link.click', function (e) {
//       var message = e.target.getAttribute("data-confirmation");
//       var confirmed = e.target.getAttribute("data-confirmed");
//       e.target.removeAttribute("data-confirmed");
//       var x = e
    

//       if(message) {
//         var new_event = new e.constructor(e.type, e)
//         e.preventDefault();
//         x.target.dispatchEvent(new_event)
//         // Swal.fire({
//         //   title: 'Are you sure?',
//         //   text: "You won't be able to revert this!",
//         //   icon: 'warning',
//         //   showCancelButton: true,
//         //   confirmButtonColor: '#3085d6',
//         //   cancelButtonColor: '#d33',
//         //   confirmButtonText: 'Yes, delete it!'
//         // }).then((result) => {
//         //   if (result.isConfirmed) {
//         //     e.target.setAttribute("data-confirmed", true)
//         //     console.log(e, "new event")
//         //     console.log(e.target.dispatchEvent(e), "3333")
//         //     return false
//         //   }
//         // })
        
        
//       }
//     }, false);
// window.confirm
// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

