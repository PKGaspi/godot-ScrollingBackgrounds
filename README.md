# Scrolling Backgrounds
## Introduction
A simple script to make tiling textures scroll endlessly.

## Usage
You can use the Scrolling Background as a simple UI Background or add a border to it and make it a Window Background.

The tool includes two scenes with their respective code: ScrollingTextureRect and Window.

### ScrollingTextureRect
The scrolling texture itself.

**Parameters**:
- **Scrolling velocity**: The speed and direction of the scrolling movement.
- **Scrolling**: Weather the texture scrolls or it stays in place.

Make sure to fill other parameters such as *Texture* and that *Stretch Mode* is on *Tile*.

### Window
The scrolling texture used as a background, a border to hide the motion and a container for contents. It also contains a standard animation for opening and closing.

**Parameters**:
- **Margin scale**: How far from the border the contents draw. 0 means no margin, the contents draw right next to the border. 2 means the margin is twice the border size.
- **Opening time**: The time it takes for the opening animation of this window to end.
- **Closing time**: The time it takes for the closing animation of this window to end.

Make sure to mark the child nodes as editable and fill the border, background and contents parameters.