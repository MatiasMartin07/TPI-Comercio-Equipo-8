using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;
using System.Globalization;

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
                ddlMarca.Items.Insert(0, new ListItem("",""));
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
                        if (string.IsNullOrWhiteSpace(seleccionado.UrlImagen))
                        {
                            imgProducto.ImageUrl = "~/Imagenes/productoSinImagen.png";
                        }
                        else
                        { 
                            imgProducto.ImageUrl = seleccionado.UrlImagen;
                        }
                        imgProducto.Visible = true;
                        btnDesactivar.Visible = seleccionado.Activo;
                        btnReactivar.Visible = !seleccionado.Activo;
                    }
                }
            }
        }

        protected void txtUrlImagen_TextChanged(object sender, EventArgs e)
        {
            string url = txtUrlImagen.Text.Trim();

            imgProducto.ImageUrl = url;
            imgProducto.Visible = !string.IsNullOrEmpty(url);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
               
            Page.Validate("Producto");
            if (!Page.IsValid) 
            {
                return;
            }

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

                Response.Redirect("Productos.aspx", false);
                Context.ApplicationInstance.CompleteRequest();

            }
            catch (Exception)
            {

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