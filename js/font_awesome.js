import {config, dom, library} from '@fortawesome/fontawesome-svg-core'
import {
  faEnvelope,
  faLock
} from '@fortawesome/free-solid-svg-icons'

config.keepOriginalSource = false

library.add(
  faEnvelope,
  faLock
)

dom.watch()
