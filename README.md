# Flutter Drag and Drop

A small Flutter app that demonstrates `LongPressDraggable` and `DragTarget`.

Long-press a food item, drag it onto one of the people at the bottom, and let go. That person's cart total and item count update. The person highlights in red while you're hovering over them.

This follows the official Flutter "Drag a UI element" cookbook recipe. The one change from the recipe: it uses placeholder images from the network instead of bundled asset files, so it runs with no setup.

## Running it

You need Flutter installed. Then:

```
flutter create drag_demo
cd drag_demo
```

Replace `lib/main.dart` with the `main.dart` from this folder, then:

```
flutter run
```

## How it works

There are two pieces doing the actual work.

`LongPressDraggable<Item>` wraps each menu row. It carries the item as `data`, shows a follow-your-finger image through `feedback`, and uses `pointerDragAnchorStrategy` to keep that image centered under your finger.

`DragTarget<Item>` wraps each person. Its `builder` redraws the person while something hovers over them (that's the red highlight), and `onAcceptWithDetails` runs when a matching item is dropped, adding it to that person's cart.

The `<Item>` type on both sides is what pairs them. A `DragTarget<Item>` only accepts a `LongPressDraggable<Item>` — drop the wrong type and nothing happens.

## Files

- `main.dart` — the full example
- `README.md` — this file