unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  System.IOUtils, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.ImageList, FMX.ImgList;

type
  TForm1 = class(TForm)
    fdConn: TFDConnection;
    qryUsuarios: TFDQuery;
    qryUsuariosNOME: TStringField;
    qryUsuariosFOTO: TBlobField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Circle1: TCircle;
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Button2: TButton;
    ListView1: TListView;
    Button3: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ImageList1: TImageList;
    ListView2: TListView;
    LinkListControlToField2: TLinkListControlToField;
    procedure fdConnBeforeConnect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView2UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Circle1.Fill.Bitmap.Bitmap.LoadFromFile('D:\Lives\Tira-Teima\Listview Imagens Redondas\Imagens\1.png');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bmp, msk : TBitmap;
begin
  bmp := nil;
  msk := nil;
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Bitmap);
    msk := TBitmap.Create;
    msk.Assign(Image2.Bitmap);

    Image3.Bitmap.CreateFromBitmapAndMask(bmp, msk);
  finally
    bmp.Free;
    msk.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  qryUsuarios.Active := True;
end;

procedure TForm1.fdConnBeforeConnect(Sender: TObject);
begin
  {$IFNDEF MSWINDOWS}
    fdConn.Params.Values['Database'] := System.IOUtils.TPath.Combine(
      System.IOUtils.TPath.GetDocumentsPath, 'Database.db');
  {$ELSE}
    fdConn.Params.Values['Database'] := 'D:\Lives\Tira-Teima\Listview Imagens Redondas\Database.db';
  {$ENDIF}
end;

procedure TForm1.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  bmp : TBitmap;
  msk : TBitmap;
begin
  bmp := nil;
  msk := nil;
  try
    bmp := TBitmap.Create;
    bmp.Assign(AItem.Bitmap);

    msk := TBitmap.Create;
    //msk.Assign(ImageList1.Bitmap(TSizeF.Create(100, 100), 0));
    msk.Assign(Image2.Bitmap);

    AItem.Bitmap.CreateFromBitmapAndMask(bmp, msk);
  finally
    bmp.Free;
    msk.Free;
  end;
end;

procedure TForm1.ListView2UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  bmp : TBitmap;
  msk : TBitmap;
begin
  bmp := nil;
  msk := nil;
  try
    bmp := TBitmap.Create;
    bmp.Assign(((AItem.Objects.FindDrawable('Image2') as TListItemImage).Bitmap));

    msk := TBitmap.Create;
    //msk.Assign(ImageList1.Bitmap(TSizeF.Create(100, 100), 0));
    msk.Assign(Image2.Bitmap);

    (AItem.Objects.FindDrawable('Image2') as TListItemImage).Bitmap.CreateFromBitmapAndMask(bmp, msk);
  finally
    bmp.Free;
    msk.Free;
  end;
end;

end.
