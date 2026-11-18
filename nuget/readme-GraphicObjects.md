# GraphicObjects

Graphic object model for WinForms design surfaces — text, images, shapes,
lines and stars, plus collection, undo/redo history and image filters.

Part of [DesignSurface](https://github.com/DwainSnickles/DesignSurfaceCSharp)
(.NET Framework 4.8) / [DesignSurface.NET](https://github.com/DwainSnickles/DesignSurface.NET)
(.NET 8+). Used by
[GraphicsWorkshop](https://github.com/DwainSnickles/GraphicsWorkshop).

## Supported frameworks

| Target | Assembly |
|---|---|
| .NET Framework 4.8 | `lib/net48/GraphicObjects.dll` |
| .NET 8+ (Windows, WinForms) | `lib/net8.0-windows7.0/GraphicObjects.dll` |

## Install

```powershell
dotnet add package GraphicObjects
```

## Usage

```csharp
var text = new GraphicObjects.TextGraphic(
    new Point(100, 100), "Hello", new Font("Arial", 24), Color.Black);

surface.drawingObjects.Add(text); // surface = DesignSurface.DesignSurface
```

## Support

If this project saved you some time, you can leave a tip at [ko-fi.com/dwainhsnickles](https://ko-fi.com/dwainhsnickles) (cards, no account needed) or [paypal.me/YTDPlatinum](https://paypal.me/YTDPlatinum). Bug reports and pull requests are welcome too.

## License

Derived from the Microsoft DesignSurface sample; see the
[repository](https://github.com/DwainSnickles/DesignSurfaceCSharp) for details.
