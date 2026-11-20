using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.IO;
using Negocio;
using Dominio;


namespace TPI_FINAL_GRUPO8
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int idProducto;
            if (!IsPostBack)
            {
                MarcaNegocio negocio = new MarcaNegocio();

                ddlMarca.DataSource = negocio.Listar();
                ddlMarca.DataValueField = "IdMarca";
                ddlMarca.DataTextField = "Nombre";
                ddlMarca.DataBind();
                ddlMarca.Items.Insert(0, new ListItem("", ""));
                ddlMarca.SelectedIndex = 0;

                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();

                ddlCategoria.DataSource = categoriaNegocio.Listar(incluirInactivas: true);
                ddlCategoria.DataValueField = "IdCategoria";
                ddlCategoria.DataTextField = "Nombre";
                ddlCategoria.DataBind();
                ddlCategoria.Items.Insert(0, new ListItem("", ""));
                ddlCategoria.SelectedIndex = 0;

                string id = Request.QueryString["id"];

                if (int.TryParse(id, out idProducto))
                {
                    ProductoNegocio productoNegocio = new ProductoNegocio();
                    Producto seleccionado = productoNegocio.BuscarPorId(idProducto);

                    if (seleccionado != null)
                    {
                        tituloProducto.InnerText = "Editar producto";
                        txtNombre.Text = seleccionado.Nombre;
                        ddlMarca.SelectedValue = seleccionado.Marca.IdMarca.ToString();
                        ddlCategoria.SelectedValue = seleccionado.Categoria.IdCategoria.ToString();
                        txtStockActual.Text = seleccionado.StockActual.ToString();
                        txtStockMinimo.Text = seleccionado.StockMinimo.ToString();
                        txtUltimoPrecioCompra.Text = seleccionado.UltimoPrecioCompra.ToString();
                        txtPorcentajeGanancia.Text = seleccionado.PorcentajeGanancia.ToString();
                        txtUrlImagen.Text = seleccionado.UrlImagen;
                        imgProducto.ImageUrl = ObtenerUrlImagen(seleccionado.UrlImagen);
                        imgProducto.Visible = true;
                        btnDesactivar.Visible = seleccionado.Activo;
                        btnReactivar.Visible = !seleccionado.Activo;
                    }
                }
            }
        }

        private string ObtenerUrlImagen(string enlace)
        {
            string url = (enlace ?? "").Trim();

            if (url.Length == 0)
            {
                return "~/Imagenes/productoSinImagen.png";
            }

            Uri direccion;
            if (!Uri.TryCreate(url, UriKind.Absolute, out direccion) ||
                !direccion.Host.Equals("drive.google.com", StringComparison.OrdinalIgnoreCase))
            {
                return url;
            }

            string idImagen = HttpUtility.ParseQueryString(direccion.Query)["id"];
            string[] partes = direccion.AbsolutePath.Split(
                new[] { '/' },
                StringSplitOptions.RemoveEmptyEntries);

            if (partes.Length >= 3 &&
                partes[0] == "file" &&
                partes[1] == "d")
            {
                idImagen = partes[2];
            }

            if (string.IsNullOrWhiteSpace(idImagen))
            {
                return url;
            }

            return "https://drive.google.com/thumbnail?id=" +
                Uri.EscapeDataString(idImagen) + "&sz=w800";
        }

        protected void txtUrlImagen_TextChanged(object sender, EventArgs e)
        {
            imgProducto.ImageUrl = ObtenerUrlImagen(txtUrlImagen.Text);
            imgProducto.Visible = true;
        }

        private string GuardarImagenProducto()
        {
            string carpeta = Server.MapPath("~/Imagenes/Productos/");
            string nombreArchivo;
            string rutaFisica;

            using (var imagen = System.Drawing.Image.FromStream(
                fuImagenProducto.PostedFile.InputStream))
            {
                var formato = imagen.RawFormat;
                string extension;

                if (formato.Equals(System.Drawing.Imaging.ImageFormat.Jpeg))
                {
                    extension = ".jpg";
                }
                else if (formato.Equals(System.Drawing.Imaging.ImageFormat.Png))
                {
                    extension = ".png";
                }
                else
                {
                    throw new HttpException(400, "Elegí una imagen JPG o PNG.");
                }

                Directory.CreateDirectory(carpeta);

                nombreArchivo = Guid.NewGuid().ToString("N") + extension;
                rutaFisica = Path.Combine(carpeta, nombreArchivo);

                imagen.Save(rutaFisica, formato);
            }

            return "~/Imagenes/Productos/" + nombreArchivo;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            Page.Validate("Producto");
            if (!Page.IsValid)
            {
                return;
            }

            string rutaImagenNueva = null;

            try
            {
                Producto nuevo = new Producto();

                nuevo.Nombre = txtNombre.Text.Trim();

                nuevo.UrlImagen = txtUrlImagen.Text.Trim();

                nuevo.Marca = new Marca();
                nuevo.Marca.IdMarca = int.Parse(ddlMarca.SelectedValue);

                nuevo.Categoria = new Categoria();
                nuevo.Categoria.IdCategoria = int.Parse(ddlCategoria.SelectedValue);

                nuevo.StockActual = int.Parse(txtStockActual.Text);
                nuevo.StockMinimo = int.Parse(txtStockMinimo.Text);

                nuevo.UltimoPrecioCompra = decimal.Parse(txtUltimoPrecioCompra.Text);

                nuevo.PorcentajeGanancia = decimal.Parse(txtPorcentajeGanancia.Text);

                ProductoNegocio negocio = new ProductoNegocio();

                string id = Request.QueryString["id"];

                if (fuImagenProducto.HasFile)
                {
                    rutaImagenNueva = GuardarImagenProducto();
                    nuevo.UrlImagen = rutaImagenNueva;
                }



                if (id == null)
                {
                    negocio.Agregar(nuevo);
                }
                else
                {
                    int idProducto;

                    if (!int.TryParse(id, out idProducto) || idProducto <= 0)
                    {
                        throw new HttpException(400, "El ID del producto no es válido.");
                    }

                    nuevo.IdProducto = idProducto;
                    negocio.Modificar(nuevo);
                }

                rutaImagenNueva = null;
                Response.Redirect("Productos.aspx", false);
                Context.ApplicationInstance.CompleteRequest();

            }
            catch (Exception)
            {
                if (rutaImagenNueva != null)
                {
                    File.Delete(Server.MapPath(rutaImagenNueva));
                }

                throw;
            }
        }

        protected void btnDesactivar_Click(object sender, EventArgs e)
        {
            btnDesactivar.Visible = false;
            pnlConfirmarDesactivacion.Visible = true;
        }

        protected void btnCancelarDesactivacion_Click(object sender, EventArgs e)
        {
            pnlConfirmarDesactivacion.Visible = false;
            btnDesactivar.Visible = true;
        }

        protected void btnConfirmarDesactivacion_Click(object sender, EventArgs e)
        {
            int idProducto;

            if (!int.TryParse(Request.QueryString["id"], out idProducto) || idProducto <= 0)
            {
                throw new HttpException(400, "El ID del producto no es válido.");
            }

            ProductoNegocio negocio = new ProductoNegocio();
            negocio.Desactivar(idProducto);

            Response.Redirect("Productos.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
        protected void btnReactivar_Click(object sender, EventArgs e)
        {
            int idProducto;

            if (!int.TryParse(Request.QueryString["id"], out idProducto) || idProducto <= 0)
            {
                throw new HttpException(400, "El ID del producto no es válido.");
            }

            ProductoNegocio negocio = new ProductoNegocio();
            negocio.Reactivar(idProducto);

            Response.Redirect("Productos.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

    }
}