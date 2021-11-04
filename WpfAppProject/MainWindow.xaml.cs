using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;



namespace WpfAppProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {


        public MainWindow()
        {

            InitializeComponent();

        }

        //Datapath Connection to Dabase

        static string conString = @"Data Source = (LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\USERS\BRIAN\DESKTOP\WpfAppProject\DatabaseProject.mdf;Integrated Security = True; Connect Timeout = 30";

        SqlConnection connection = new SqlConnection(conString);


        //Loaded Methode Loaded for displaying
        private void EmployeesandOrders_Loaded(object sender, RoutedEventArgs e)
        {
            display();
        }

        //Methode to display Dataviews (tables) when launching program

        private void display()
        {

            //DataView
            BindDataEmployees();
            BindDataOrders();


            //Combobox
            BindDataProducts();
            BindDataCategories();

        }

        //Erase textbox/reset (employees)

        private void clear()
        {
            textBoxLastName.Text = "";
            textBoxFirstName.Text = "";
            textBoxDateOfBirth.Text = "";
            textBoxAddress.Text = "";
            textBoxTitle.Text = "";
            textBoxHiringDate.Text = "";
            textBoxState.Text = "";
            textBoxTelephone.Text = "";
            textBoxCountry.Text = "";
            textBoxZipCode.Text = "";
            textBoxExtension.Text = "";
            textBoxNotes.Text = "";
            //ComboBox
            comboBoxCategories.Text = "";
            comboBoxProducts.Text = "";

            textBoxEmployeeID.Text = "";

        }

        //Method that clears/resets (Reset button)

        private void resetBtn_Click(object sender, RoutedEventArgs e)
        {
            display();
            clear();

        }

        //Method to save and add new employee (Save button)

        private void saveBtn_Click(object sender, RoutedEventArgs e)

        {
            //Reset /close connection
            connection.Close();

            try
            {

                SqlCommand command = new SqlCommand(@"INSERT into Employees (EmployeeID, FirstName, LastName, Title, DateOfBirth, HiringDate, Address, State, ZipCode, Country, Telephone, Extension, Notes) Values (@EmployeeID, @FirstName, @LastName, @Title, @DateOfBirth, @HiringDate, @Address, @State, @ZipCode, @Country, @Telephone, @Extension, @Notes)", connection);
                command.Parameters.AddWithValue("@EmployeeID", textBoxEmployeeID.Text);
                command.Parameters.AddWithValue("@FirstName", textBoxFirstName.Text);
                command.Parameters.AddWithValue("@LastName", textBoxLastName.Text);
                command.Parameters.AddWithValue("@Title", textBoxTitle.Text);
                command.Parameters.AddWithValue("@DateOfBirth", textBoxDateOfBirth.Text);
                command.Parameters.AddWithValue("@HiringDate", textBoxHiringDate.Text);
                command.Parameters.AddWithValue("@Address", textBoxAddress.Text);
                command.Parameters.AddWithValue("@State", textBoxState.Text);
                command.Parameters.AddWithValue("@ZipCode", textBoxZipCode.Text);
                command.Parameters.AddWithValue("@Country", textBoxCountry.Text);
                command.Parameters.AddWithValue("@Telephone", textBoxTelephone.Text);
                command.Parameters.AddWithValue("@Extension", textBoxExtension.Text);
                command.Parameters.AddWithValue("@Notes", textBoxNotes.Text);
                connection.Open();
                command.ExecuteNonQuery();

                connection.Close();
                MessageBox.Show("The employee was added.");
                display();
                clear();

            }

            catch
            {
                MessageBox.Show("The employee you are trying to add already exists.");
                display();
                clear();
            }


        }

        //Methode to quit program MainWindow (quit button)

        private void quitBtn_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();

        }

        //Methode to update employee (update button)

        private void updateBtn_Click(object sender, RoutedEventArgs e)
        {
            //Reset /close connection
            connection.Close();

            try
            {

                SqlCommand command = new SqlCommand(@"UPDATE Employees SET LastName=@LastName, FirstName=@FirstName, Title=@Title, DateOfBirth=@DateOfBirth, 
            HiringDate=@HiringDate, Address=@Address, State=@State, ZipCode=@ZipCode, Country=@Country, Telephone=@Telephone, Extension=@Extension, Notes=@Notes
            WHERE EmployeeID=@EmployeeID", connection);
                command.Parameters.AddWithValue("@EmployeeID", textBoxEmployeeID.Text);
                command.Parameters.AddWithValue("@FirstName", textBoxFirstName.Text);
                command.Parameters.AddWithValue("@LastName", textBoxLastName.Text);
                command.Parameters.AddWithValue("@Title", textBoxTitle.Text);
                command.Parameters.AddWithValue("@DateOfBirth", textBoxDateOfBirth.Text);
                command.Parameters.AddWithValue("@HiringDate", textBoxHiringDate.Text);
                command.Parameters.AddWithValue("@Address", textBoxAddress.Text);
                command.Parameters.AddWithValue("@State", textBoxState.Text);
                command.Parameters.AddWithValue("@ZipCode", textBoxZipCode.Text);
                command.Parameters.AddWithValue("@Country", textBoxCountry.Text);
                command.Parameters.AddWithValue("@Telephone", textBoxTelephone.Text);
                command.Parameters.AddWithValue("@Extension", textBoxExtension.Text);
                command.Parameters.AddWithValue("@Notes", textBoxNotes.Text);
                connection.Open();
                command.ExecuteNonQuery();

                connection.Close();
                MessageBox.Show("The selected employee was updated.");
                display();
                clear();

            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }


        }

        //Method to delete the selected employee - Employees DataGrid (delete button)

        private void deleteBtn_Click(object sender, RoutedEventArgs e)
        {
            //Reset - fermer la connection
            connection.Close();

            try
            {
                SqlCommand command = new SqlCommand(@"DELETE FROM Employees WHERE EmployeeID = @EmployeeID", connection);
                command.Parameters.AddWithValue("@EmployeeID", textBoxEmployeeID.Text);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                MessageBox.Show("The selected employee was deleted.");
                display();
                clear();


            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        //BindDataEmployees Method to display all employees (Employees Table)
        private void BindDataEmployees()
        {
            SqlCommand command = new SqlCommand("SELECT * FROM Employees", connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);
            dataGridEmployees.ItemsSource = table.DefaultView;

        }

        //BindDataOrders Method to display all orders (Orders Table)
        private void BindDataOrders()
        {
            SqlCommand command = new SqlCommand("SELECT * FROM Orders", connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);

            dataGridOrders.ItemsSource = table.DefaultView;

        }



        //BindDataProducts Method to display all products (Products Table)

        private void BindDataProducts()
        {
            SqlCommand command = new SqlCommand("SELECT * FROM Products", connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                comboBoxProducts.Items.Add(row["ProductName"].ToString());
            }


        }


        //BindDataCategories Method to display all categories (Categories Table)

        private void BindDataCategories()
        {
            SqlCommand command = new SqlCommand("SELECT * FROM Categories", connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                comboBoxCategories.Items.Add(row["CategoryName"].ToString());
            }

        }


        // Double click event to update/delete employees and and see the employees' orders by selecting the EmployeeID
        private void dataGridEmployees_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

            try
            {
                if (dataGridEmployees.Items.Count > 0)
                {
                    textBoxEmployeeID.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["EmployeeID"].ToString();
                    textBoxLastName.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["LastName"].ToString();
                    textBoxFirstName.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["FirstName"].ToString();
                    textBoxTitle.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Title"].ToString();
                    textBoxDateOfBirth.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["DateOfBirth"].ToString();
                    textBoxHiringDate.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["HiringDate"].ToString();
                    textBoxAddress.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Address"].ToString();

                    textBoxState.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["State"].ToString();
                    textBoxZipCode.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["ZipCode"].ToString();
                    textBoxCountry.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Country"].ToString();
                    textBoxTelephone.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Telephone"].ToString();

                    textBoxExtension.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Extension"].ToString();
                    textBoxNotes.Text = ((DataRowView)dataGridEmployees.SelectedItem).Row["Notes"].ToString();

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            //Display orders for the chosen employee with the EmployeeID

            var selectedItem = dataGridEmployees.SelectedItems[0];
            var dataRow = (selectedItem as DataRowView).Row;
            var id = dataRow["EmployeeID"].ToString();

            MessageBox.Show("You have selected EmployeID :  " + id + "\nHere are the orders for this employee. \nClick reset to reset everything.");

            SqlCommand command = new SqlCommand("SELECT * FROM Orders WHERE EmployeeID = " + id, connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);

            dataGridOrders.ItemsSource = table.DefaultView;

        }


        // Doule click event to display orders selected
        private void dataGridOrders_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

            //Display the customer selected for the order with CustomerID (CustomerList XAML)

            var selectedItem = dataGridOrders.SelectedItems[0];
            var dataRow = (selectedItem as DataRowView).Row;
            var id = dataRow["CustomerID"].ToString();

            MessageBox.Show("You have chosen CustomerID :  " + id);
            string customerid = '\u0027' + id + '\u0027';


            CustomerList customers = new CustomerList(customerid);
            customers.Show();


        }

    }
}
