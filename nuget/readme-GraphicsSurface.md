# GraphicsSurface

Scroll-zoomable WinForms **design surface** control — printable page bounds,
margin guides, dot grid, object selection, undo/redo, print/print-preview and
a PropertyGrid pane — together with the **GraphicObjects** object model,
which ships as a separate NuGet package pulled in automatically as a
dependency.

Part of [DesignSurface](https://github.com/DwainSnickles/DesignSurfaceCSharp)
(.NET Framework 4.8) / [DesignSurface.NET](https://github.com/DwainSnickles/DesignSurface.NET)
(.NET 8+). Used by
[GraphicsWorkshop](https://github.com/DwainSnickles/GraphicsWorkshop).

## Supported frameworks

| Target | Assemblies |
|---|---|
| .NET Framework 4.8 | `lib/net48/GraphicsSurface.dll` |
| .NET 8+ (Windows, WinForms) | `lib/net8.0-windows7.0/GraphicsSurface.dll` |

## Install

```powershell
dotnet add package GraphicsSurface
```

## Usage

```csharp
var surface = new DesignSurface.DesignSurface
{
    Dock = DockStyle.Fill,
    PageSize = DesignSurface.PageSizeKind.Letter,
    Orientation = DesignSurface.GridOrientation.Portrait,
};

surface.drawingObjects.Add(new GraphicObjects.TextGraphic(
    new Point(100, 100), "Hello", new Font("Arial", 24), Color.Black));

surface.SelectionChanged += (s, e) => { /* react to selection */ };
surface.PrintPreview();
```

## Support

If this project saved you some time, you can leave a tip at [ko-fi.com/dwainhsnickles](https://ko-fi.com/dwainhsnickles) (cards, no account needed) or [paypal.me/YTDPlatinum](https://paypal.me/YTDPlatinum). Bug reports and pull requests are welcome too.

## License

Derived from the Microsoft DesignSurface sample; see the
[repository](https://github.com/DwainSnickles/DesignSurface.NET) for details.
