using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace TPI_FINAL_GRUPO8
{
    public partial class FormCompras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            if (usuario.Rol != "Administrador")
            {
                Response.Redirect("Inicio.aspx", false);
                return;
            }

            if (!(IsPostBack))
            {
                txtFechaCompra.Text = DateTime.Today.ToString("yyyy-MM-dd");

                ProveedoresNegocio negocio = new ProveedoresNegocio();

                List<Dominio.Proveedores> listaProveedores = negocio.Listar();
                List<Dominio.Proveedores> proveedoresActivos = new List<Dominio.Proveedores>();

                foreach (Dominio.Proveedores proveedor in listaProveedores)
                {
                    if (proveedor.Activo)
                    {
                        proveedoresActivos.Add(proveedor);
                    }
                }

                ddlProveedor.DataSource = proveedoresActivos;
                ddlProveedor.DataTextField = "RazonSocial";
                ddlProveedor.DataValueField = "Id";
                ddlProveedor.DataBind();

                ddlProveedor.Items.Insert(0, new ListItem("Seleccione un proveedor", ""));

                ProductoNegocio productoNegocio = new ProductoNegocio();

                List<Dominio.Producto> listaProductos = productoNegocio.Listar();
                List<Dominio.Producto> productosActivos = new List<Dominio.Producto>();

                foreach (Dominio.Producto producto in listaProductos)
                {
                    if (producto.Activo)
                    {
                        productosActivos.Add(producto);
                    }
                }

                ddlProducto.DataSource = productosActivos;
                ddlProducto.DataTextField = "Nombre";
                ddlProducto.DataValueField = "IdProducto";
                ddlProducto.DataBind();

                ddlProducto.Items.Insert(0, new ListItem("Seleccione un producto", ""));
            }
        }
        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            lblErrorCompra.Text = "";

            int idProducto;
            int cantidad;
            decimal precio;

            if (!int.TryParse(ddlProducto.SelectedValue, out idProducto))
            {
                lblErrorCompra.Text = "Seleccione un producto.";
                return;
            }

            if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad <= 0)
            {
                lblErrorCompra.Text = "Ingrese una cantidad mayor que cero.";
                return;
            }

            if (!decimal.TryParse(txtPrecioUnitario.Text, out precio) || precio < 0)
            {
                lblErrorCompra.Text = "Ingrese un precio válido.";
                return;
            }

            ProductoNegocio negocio = new ProductoNegocio();
            Producto producto = negocio.BuscarPorId(idProducto);

            if (producto == null || !producto.Activo)
            {
                lblErrorCompra.Text = "El producto seleccionado no está disponible.";
                return;
            }

            List<Dominio.DetalleCompra> detalles = Session["DetalleCompra"] as List<Dominio.DetalleCompra>;

            if (detalles == null)
            {
                detalles = new List<Dominio.DetalleCompra>();
            }

            Dominio.DetalleCompra detalle = new Dominio.DetalleCompra();
            detalle.Producto = producto;
            detalle.Cantidad = cantidad;
            detalle.PrecioUnitario = precio;
            detalles.Add(detalle);

            Session["DetalleCompra"] = detalles;

            gvDetalleCompra.DataSource = detalles;
            gvDetalleCompra.DataBind();

            decimal total = 0;
            foreach (Dominio.DetalleCompra item in detalles)
            {
                total += item.SubTotal;
            }

            lblTotalCompra.Text = total.ToString("N2");
        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            lblErrorCompra.Text = "";

            int idProveedor;
            DateTime fecha;

            try
            {
                idProveedor = int.Parse(ddlProveedor.SelectedValue);

                if (idProveedor <= 0)
                {
                    lblErrorCompra.Text = "Seleccione un proveedor.";
                    return;
                }
            }
            catch (FormatException)
            {
                lblErrorCompra.Text = "Seleccione un proveedor.";
                return;
            }

            try
            {
                fecha = DateTime.Parse(txtFechaCompra.Text);
            }
            catch (FormatException)
            {
                lblErrorCompra.Text = "Ingrese una fecha válida.";
                return;
            }

            List<Dominio.DetalleCompra> detalles =
                Session["DetalleCompra"] as List<Dominio.DetalleCompra>;

            if (detalles == null || detalles.Count == 0)
            {
                lblErrorCompra.Text = "Agregue al menos un producto.";
                return;
            }

            Dominio.Compras compra = new Dominio.Compras();
            compra.Fecha = fecha;
            compra.Proveedor = new Dominio.Proveedores();
            compra.Proveedor.Id = idProveedor;
            compra.Detalles = detalles;

            try
            {
                ComprasNegocio negocio = new ComprasNegocio();
                negocio.Registrar(compra);

                Session.Remove("DetalleCompra");

                Response.Redirect("Compras.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblErrorCompra.Text = "No se pudo registrar la compra: " + ex.Message;
            }
        }
    }
}