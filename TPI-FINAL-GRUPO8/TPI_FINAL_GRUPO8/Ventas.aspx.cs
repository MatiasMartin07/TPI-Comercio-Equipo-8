using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Ventas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtNombre.Enabled = false;
            txtPrecio.Enabled = false;
            txtSubtotal.Enabled = false;
            txtNroFactura.Enabled = false;

            if (!IsPostBack)
            {
                CargarSiguienteFactura();
            }
        }
        private void CargarSiguienteFactura()
        {
            try
            {
                VentaNegocio negocio = new VentaNegocio();
                txtNroFactura.Text = negocio.ObtenerSiguienteNumeroFactura();
            }
            catch (Exception ex)
            {
                txtNroFactura.Text = "Error: a cargar la factura";
            }
        }

        protected void txtDni_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtDni.Text))
                {
                    lblErrorDni.Text = string.Empty;
                    txtDni.BorderColor = System.Drawing.Color.Gray;
                }
                ClienteNegocio negocio = new ClienteNegocio();
                Cliente cliente = negocio.buscarDni(txtDni.Text);

                if (cliente != null)
                {
                    if (!cliente.Activo)
                    {
                        lblErrorDni.Text = "El cliente se encuantra Inactivo";
                        txtDni.BorderColor = System.Drawing.Color.Red;
                        txtNombre.Text = string.Empty;
                        Session["clienteEncontrado"] = null;
                        return;
                    }

                    txtNombre.Text = cliente.Nombre;
                    Session["clienteEncontrado"] = cliente;
                }
                else
                {
                    txtNombre.Text = string.Empty;
                    Session["clienteEncontrado"] = null;
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void btnValidar_Click(object sender, EventArgs e)
        {
            ClienteNegocio negocio = new ClienteNegocio();
            try
            {
                if (string.IsNullOrEmpty(txtDni.Text))
                {
                    lblErrorDni.Text = "Ingrese un DNI o CUIT";
                    txtDni.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtDni.BorderColor = System.Drawing.Color.Empty;
                    lblErrorDni.Text = "";
                    Cliente cliente = negocio.buscarDni(txtDni.Text);
                    if (cliente == null)
                    {
                        lblErrorDni.Text = "Este DNI / CUIT no esta registrado";
                        txtDni.BorderColor = System.Drawing.Color.Red;
                        return;
                    }
                    if (!cliente.Activo)
                    {
                        lblErrorDni.Text = "El cliente se encuentra Inactivo";
                        txtDni.BorderColor = System.Drawing.Color.Red;
                        txtNombre.Text = string.Empty;
                        Session["clienteEncontrado"] = null;
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void txtIdProducto_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtIdProducto.Text))
                {
                    lblErrorId.Text = string.Empty;
                    txtIdProducto.BorderColor = System.Drawing.Color.Gray;
                }

                ProductoNegocio negocio = new ProductoNegocio();
                Producto producto = negocio.BuscarPorId(int.Parse(txtIdProducto.Text));

                if (producto != null)
                {
                    decimal precio = producto.UltimoPrecioCompra;
                    decimal porcentaje = producto.PorcentajeGanancia;
                    decimal precioFinal = calcularPrecio(precio, porcentaje);
                    txtNombreProducto.Text = producto.Nombre;
                    txtPrecio.Text = precioFinal.ToString("N2");
                    Session["productoEncontrado"] = producto;
                }
                else
                {
                    txtNombreProducto.Text = string.Empty;
                    txtPrecio.Text = string.Empty;
                    Session["productoEncontrado"] = producto;
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        private decimal calcularPrecio(decimal precio, decimal porcentaje)
        {
            decimal precioVenta = 0;
            if (precio > 0)
            {
                precioVenta = precio * (1 + porcentaje / 100);
                return precioVenta;
            }
            return 0;
        }

        protected void btnBuscarProducto_Click(object sender, EventArgs e)
        {
            string nombre = txtNombreProducto.Text.Trim();

            if (string.IsNullOrWhiteSpace(nombre))
            {
                lblErrorProducto.Text = "Escribí el nombre del producto.";
                txtIdProducto.Text = string.Empty;
                txtPrecio.Text = string.Empty;
                return;
            }

            ProductoNegocio negocio = new ProductoNegocio();
            Producto encontrado = negocio.buscarPorNombre(nombre);

            if (encontrado == null)
            {
                lblErrorProducto.Text = "No se encontró ese producto.";
                txtIdProducto.Text = string.Empty;
                txtPrecio.Text = string.Empty;
                Session.Remove("ExisteProducto");
                return;
            }

            Producto producto = negocio.BuscarPorId(encontrado.IdProducto);

            txtIdProducto.Text = producto.IdProducto.ToString();
            txtNombreProducto.Text = producto.Nombre;
            txtPrecio.Text = calcularPrecio(
            producto.UltimoPrecioCompra,
            producto.PorcentajeGanancia).ToString("N2");

            Session["ExisteProducto"] = producto;
            lblErrorProducto.Text = "";
        }

        protected void txtCantidad_TextChanged(object sender, EventArgs e)
        {
            try
            {
                decimal precio = decimal.Parse(txtPrecio.Text);
                int cantidad = int.Parse(txtCantidad.Text);
                decimal total = 0;

                total = precio * cantidad;

                txtSubtotal.Text = total.ToString("N2");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
        private List<DetalleVenta> listaCarrito
        {
            get
            {
                if (Session["listaCarrito"] == null)
                    Session["listaCarrito"] = new List<DetalleVenta>();

                return (List<DetalleVenta>)Session["listaCarrito"];
            }
            set
            {
                Session["listaCarrito"] = value;
            }
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtIdProducto.Text))
                {
                    lblErrorId.Text = "Ingresar el Id Producto";
                    txtIdProducto.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtIdProducto.BorderColor = System.Drawing.Color.Empty;
                    lblErrorId.Text = "";
                }

                // cargar los productos

                int id = int.Parse(txtIdProducto.Text);
                int cantidad = int.Parse(txtCantidad.Text);
                decimal precio = decimal.Parse(txtPrecio.Text);
                DetalleVenta detalle = new DetalleVenta();
                detalle.Producto = new Producto();
                detalle.Producto.IdProducto = id;
                detalle.NombreProducto = txtNombreProducto.Text;
                detalle.Cantidad = cantidad;
                detalle.PrecioUnitario = precio;
                detalle.SubTotal = cantidad * precio;

                //comprobar si hay stock

                ProductoNegocio negocio = new ProductoNegocio();
                Producto producto = negocio.BuscarPorId(int.Parse(txtIdProducto.Text));

                int cantidadProductos = 0;
                foreach (DetalleVenta item in listaCarrito)
                {
                    if (item.Producto.IdProducto == id)
                    {
                        cantidadProductos += item.Cantidad;
                    }
                }
                if (producto == null || (cantidadProductos + cantidad) > producto.StockActual)
                {
                    lblErrorId.Text = "No hay stock suficiente ";
                    txtIdProducto.Text = string.Empty;
                    txtNombreProducto.Text = string.Empty;
                    txtCantidad.Text = string.Empty;
                    txtPrecio.Text = string.Empty;
                    txtSubtotal.Text = string.Empty;
                    return;
                }

                listaCarrito.Add(detalle);

                gvCarritoProducto.DataSource = listaCarrito;
                gvCarritoProducto.DataBind();
                calcularTotal();

                //vaciar text
                txtIdProducto.Text = string.Empty;
                txtNombreProducto.Text = string.Empty;
                txtCantidad.Text = string.Empty;
                txtPrecio.Text = string.Empty;
                txtSubtotal.Text = string.Empty;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }
        private void calcularTotal()
        {
            decimal total = 0;
            foreach (DetalleVenta item in listaCarrito)
            {
                total += item.SubTotal;
            }
            txtTotal.Text = total.ToString("N2");
        }

        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
            Cliente cliente = Session["clienteEncontrado"] as Cliente;
            if (cliente == null)
            {
                lblError.Text = "No se puede Finalizar la venta: Falta seleccionar Cliente";
                return;
            }
            if(listaCarrito == null || listaCarrito.Count == 0)
            {
                lblError.Text = "El carrito está vacío";
                return;
            }

            ProductoNegocio negocio = new ProductoNegocio();
            List<DetalleVenta> produDescontadoTemporalmente = new List<DetalleVenta>();
            try
            {
                foreach (DetalleVenta detalle in listaCarrito)
                {
                  bool stockOk = negocio.verificarStock(detalle.Producto.IdProducto, detalle.Cantidad);
                    if (!stockOk)
                    {
                        lblError.Text = ("No hay stock suficiente del producto: " + detalle.NombreProducto);

                        foreach (DetalleVenta revertir in produDescontadoTemporalmente)
                        {
                            negocio.verificarStock(revertir.Producto.IdProducto,-revertir.Cantidad);
                        }
                        return;
                    }
                    produDescontadoTemporalmente.Add(detalle);
                }
                Venta NuevaVenta = new Venta();
                NuevaVenta.Cliente = cliente;
                NuevaVenta.Fecha = DateTime.Now;
                NuevaVenta.Total = decimal.Parse(txtTotal.Text);
                NuevaVenta.NroFactura = txtNroFactura.Text;
                NuevaVenta.Detalle = listaCarrito;

                VentaNegocio negocioVenta = new VentaNegocio();
                int idVenta = negocioVenta.AgregarVenta(NuevaVenta);

                DetalleVentaNegocio detalleNegocio = new DetalleVentaNegocio();
                detalleNegocio.agregarDetalleVenta(listaCarrito, idVenta);

                Session["listaCarrito"] = null;
                gvCarritoProducto.DataSource = null;
                gvCarritoProducto.DataBind();
                txtDni.Text = string.Empty;
                txtTotal.Text = string.Empty;
                CargarSiguienteFactura();
                Response.Redirect("Facturas.aspx?id=" + idVenta, false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void gvCarritoProducto_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Quitar")
                return;

            int indice;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out indice))
                return;

            List<DetalleVenta> carrito = listaCarrito;
            if (indice < 0 || indice >= carrito.Count)
                return;

            carrito.RemoveAt(indice);
            listaCarrito = carrito;
            calcularTotal();
            gvCarritoProducto.DataSource = carrito;
            gvCarritoProducto.DataBind();
            lblFactura.Text = string.Empty;

        }
    }
}
