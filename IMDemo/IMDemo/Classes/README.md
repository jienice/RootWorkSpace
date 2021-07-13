## Layer
- Socket
- Decoder/Encoder
- ImMessage
- ImMessageLayout
- DBLoader/NetworkLoader

##  Received Message Handle Flow
- Socket received data
- Data decoder trans data to ImMessage
- ImMessageCompoundHandleChain handle ImMessage
   - cached
   - notify user
   - ...
- Adapter trans ImMessage to layout, then send to ViewModel
- ViewModel notify controller show it

## Load Message Handle Flow 
- Adapter trans ImMessage to layout, then send to ViewModel
- ViewModel notify controller show it

## Send Message Handle Flow
- Adapter trans Element To ImMessage, then send to encoder
- Encoder trans ImMessage 
- Socket Send

