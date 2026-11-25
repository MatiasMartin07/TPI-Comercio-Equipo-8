using Dominio;
using MigraDoc.DocumentObjectModel;
using MigraDoc.DocumentObjectModel.Tables;
using MigraDoc.Rendering;
using System;
using System.Globalization;
using System.IO;
using PdfSharp.Drawing;


namespace TPI_FINAL_GRUPO8.Servicios
{
    public class FacturaPdf
    {
        public byte[] Generar(Venta venta)
        {
            if (venta == null || venta.Cliente == null)
            {
                throw new ArgumentException("Faltan los datos de la factura.");
            }

            if (venta.Detalle == null || venta.Detalle.Count == 0)
            {
                throw new ArgumentException("La factura no tiene productos.");
            }

            CultureInfo cultura = new CultureInfo("es-AR");

            // Crear el documento y definir la letra.
            Document documento = new Document();
            documento.Info.Title = "Factura " + venta.NroFactura;
            documento.Info.Author = "Gestión Comercial";

            documento.Styles["Normal"].Font.Name = "Arial";
            documento.Styles["Normal"].Font.Size = 10;

            // Configurar una hoja A4 con márgenes de 2 cm.
            Section seccion = documento.AddSection();
            seccion.PageSetup.PageFormat = PageFormat.A4;
            seccion.PageSetup.TopMargin = Unit.FromCentimeter(2);
            seccion.PageSetup.BottomMargin = Unit.FromCentimeter(8.5);
            seccion.PageSetup.LeftMargin = Unit.FromCentimeter(2);
            seccion.PageSetup.RightMargin = Unit.FromCentimeter(2);

            // Encabezado en dos columnas, sin bordes visibles.
            Table cabecera = seccion.AddTable();
            cabecera.Borders.Visible = false;
            cabecera.Rows.LeftIndent = Unit.FromCentimeter(0);
            cabecera.LeftPadding = 0;
            cabecera.RightPadding = 0;

            cabecera.AddColumn(Unit.FromCentimeter(10));
            cabecera.AddColumn(Unit.FromCentimeter(7));

            Row filaCabecera = cabecera.AddRow();

            // Izquierda: título y datos del cliente.
            Paragraph titulo = filaCabecera.Cells[0].AddParagraph(
                "Comprobante de Venta");
            titulo.Format.Font.Size = 18;
            titulo.Format.Font.Bold = true;
            titulo.Format.SpaceAfter = Unit.FromCentimeter(0.5);

            Paragraph etiquetaCliente = filaCabecera.Cells[0].AddParagraph(
                "Datos del Cliente");
            etiquetaCliente.Format.Font.Color = Colors.Gray;
            etiquetaCliente.Format.SpaceAfter = Unit.FromCentimeter(0.2);

            Paragraph cliente = filaCabecera.Cells[0].AddParagraph(
                "Nombre y Apellido: " + venta.Cliente.Nombre + " " +
                venta.Cliente.Apellido);
            cliente.Format.SpaceAfter = Unit.FromCentimeter(0.15);

            filaCabecera.Cells[0].AddParagraph(
                "DNI: " + venta.Cliente.Dni);

            // Derecha: número y fecha de la factura.
            filaCabecera.Cells[1].Format.Alignment =
                ParagraphAlignment.Right;

            Paragraph etiquetaFactura = filaCabecera.Cells[1].AddParagraph(
                "Factura");
            etiquetaFactura.Format.Font.Size = 15;
            etiquetaFactura.Format.Font.Color = Colors.Gray;
            etiquetaFactura.Format.SpaceAfter = Unit.FromCentimeter(0.3);

            Paragraph numero = filaCabecera.Cells[1].AddParagraph(
                "Nº: " + venta.NroFactura);
            numero.Format.SpaceAfter = Unit.FromCentimeter(0.15);

            filaCabecera.Cells[1].AddParagraph(
                "Fecha: " + venta.Fecha.ToString("dd/MM/yyyy HH:mm"));

            if (venta.Anulado)
            {
                Paragraph estado = filaCabecera.Cells[1].AddParagraph(
                    "ANULADA");
                estado.Format.Font.Bold = true;
                estado.Format.Font.Color = Colors.Red;
                estado.Format.SpaceBefore = Unit.FromCentimeter(0.3);
            }

            // Línea divisoria debajo del encabezado.
            Paragraph separador = seccion.AddParagraph();
            separador.Format.Font.Size = 1;
            separador.Format.SpaceBefore = Unit.FromCentimeter(0.5);
            separador.Format.SpaceAfter = Unit.FromCentimeter(0.6);
            separador.Format.Borders.Bottom.Width = 0.5;
            separador.Format.Borders.Bottom.Color = Colors.LightGray;

            // Tabla de productos: el ancho total es de 17 cm.
            Table tabla = seccion.AddTable();
            tabla.Borders.Width = 0.5;
            tabla.Borders.Color = Colors.LightGray;
            tabla.Rows.LeftIndent = Unit.FromCentimeter(0);
            tabla.TopPadding = Unit.FromCentimeter(0.22);
            tabla.BottomPadding = Unit.FromCentimeter(0.22);
            tabla.LeftPadding = Unit.FromCentimeter(0.2);
            tabla.RightPadding = Unit.FromCentimeter(0.2);
            tabla.Rows.VerticalAlignment = VerticalAlignment.Center;

            tabla.AddColumn(Unit.FromCentimeter(8));
            tabla.AddColumn(Unit.FromCentimeter(2));
            tabla.AddColumn(Unit.FromCentimeter(3.5));
            tabla.AddColumn(Unit.FromCentimeter(3.5));

            tabla.Columns[1].Format.Alignment = ParagraphAlignment.Center;
            tabla.Columns[2].Format.Alignment = ParagraphAlignment.Right;
            tabla.Columns[3].Format.Alignment = ParagraphAlignment.Right;

            Row encabezado = tabla.AddRow();
            encabezado.HeadingFormat = true;
            encabezado.Shading.Color = Color.FromRgb(242, 244, 247);
            encabezado.Format.Font.Bold = true;

            encabezado.Cells[0].AddParagraph("Producto");
            encabezado.Cells[1].AddParagraph("Cantidad");
            encabezado.Cells[2].AddParagraph("Precio unitario");
            encabezado.Cells[3].AddParagraph("Subtotal");

            foreach (DetalleVenta detalle in venta.Detalle)
            {
                Row fila = tabla.AddRow();

                fila.Height = Unit.FromCentimeter(0.8);
                fila.HeightRule = RowHeightRule.AtLeast;

                string nombre = detalle.Producto != null
                    ? detalle.Producto.Nombre
                    : detalle.NombreProducto;

                fila.Cells[0].AddParagraph(nombre ?? "");
                fila.Cells[1].AddParagraph(detalle.Cantidad.ToString());
                fila.Cells[2].AddParagraph(
                    detalle.PrecioUnitario.ToString("C2", cultura));
                fila.Cells[3].AddParagraph(
                    detalle.SubTotal.ToString("C2", cultura));
            }

            
            // Numeración de páginas.
            Paragraph pie = seccion.Footers.Primary.AddParagraph();
            pie.Format.Alignment = ParagraphAlignment.Center;
            pie.AddText("Página ");
            pie.AddPageField();
            pie.AddText(" de ");
            pie.AddNumPagesField();

            // Generar las páginas del PDF.
            PdfDocumentRenderer renderizador = new PdfDocumentRenderer();
            renderizador.Document = documento;
            renderizador.RenderDocument();

            // Colocar el cierre cerca del pie de la última página.
            int indiceUltimaPagina =
                renderizador.PdfDocument.PageCount - 1;

            var ultimaPagina =
                renderizador.PdfDocument.Pages[indiceUltimaPagina];

            double margen = Unit.FromCentimeter(2).Point;
            double ancho = ultimaPagina.Width.Point - margen * 2;
            double posicionVertical = ultimaPagina.Height.Point - Unit.FromCentimeter(7.8).Point;

            using (XGraphics dibujo = XGraphics.FromPdfPage(ultimaPagina))
            {
                XPen linea = new XPen(XColors.LightGray, 0.5);

                dibujo.DrawLine(
                    linea,
                    margen,
                    posicionVertical,
                    margen + ancho,
                    posicionVertical);

                XFont letraGracias = new XFont(
                    "Arial", 10, XFontStyleEx.Regular);

                XFont letraTotal = new XFont(
                    "Arial", 15, XFontStyleEx.Bold);

                dibujo.DrawString(
                    "Gracias por su compra",
                    letraGracias,
                    XBrushes.Gray,
                    new XRect(
                        margen,
                        posicionVertical + 12,
                        ancho / 2,
                        25),
                    XStringFormats.TopLeft);

                dibujo.DrawString(
                    "Total: " + venta.Total.ToString("C2", cultura),
                    letraTotal,
                    XBrushes.Black,
                    new XRect(
                        margen + ancho / 2,
                        posicionVertical + 12,
                        ancho / 2,
                        25),
                    XStringFormats.TopRight);
            }

            // Devolver el archivo listo para descargar.
            using (MemoryStream archivo = new MemoryStream())
            {
                renderizador.PdfDocument.Save(archivo, false);
                return archivo.ToArray();
            }
        }
    }
}