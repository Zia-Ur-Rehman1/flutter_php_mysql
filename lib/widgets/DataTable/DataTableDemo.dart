import 'package:flutter/material.dart';
import 'Employee.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Flutter Data Table";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<Employee> _employees;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late Employee _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _getEmployees();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _getEmployees();
      }
    });
  }

  _addEmployee() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_nameController.text, _emailController.text,
            _phoneController.text, _addressController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
      }
      _clearValues();
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title);
      print("Length: ${employees.length}");
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        setState(() {
          _employees.remove(employee);
        });
        _getEmployees();
      }
    });
  }

  _updateEmployee(Employee employee) {
    _showProgress('Updating Employee...');
    Services.updateEmployee(
            employee.id, _nameController.text, _emailController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _nameController.text = '';
        _emailController.text = '';
        _phoneController.text = '';
        _addressController.text = '';
      }
    });
  }

  _setValues(Employee employee) {
    _nameController.text = employee.getname;
    _emailController.text = employee.getemail;
    _phoneController.text = employee.getphone;
    _addressController.text = employee.getaddress;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _nameController.text = '';
    _emailController.text = '';
    _phoneController.text = '';
    _addressController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the employee id"),
            DataColumn(
                label: Text(
                  "Name",
                ),
                numeric: false,
                tooltip: "This is the full name"),
            DataColumn(
                label: Text("Phone"),
                numeric: false,
                tooltip: "This is phone no"),
            DataColumn(
                label: Text("Address"),
                numeric: false,
                tooltip: "This is the address"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _employees
              .map(
                (employee) => DataRow(
                  cells: [
                    DataCell(
                      Text(employee.id.toString()),
                      onTap: () {
                        print("Tapped " + employee.getname);
                        _setValues(employee);
                        _selectedEmployee = employee;
                      },
                    ),
                    DataCell(
                      Text(
                        employee.getname.toUpperCase(),
                      ),
                      onTap: () {
                        print("Tapped " + employee.getname);
                        _setValues(employee);
                        _selectedEmployee = employee;
                      },
                    ),
                    DataCell(
                      Text(
                        employee.getemail.toUpperCase(),
                      ),
                      onTap: () {
                        print("Tapped " + employee.getname);
                        _setValues(employee);
                        _selectedEmployee = employee;
                      },
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteEmployee(employee);
                        },
                      ),
                      onTap: () {
                        print("Tapped " + employee.getname);
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration.collapsed(
                  hintText: "First Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration.collapsed(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration.collapsed(
                  hintText: "Phone",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration.collapsed(
                  hintText: "Address",
                ),
              ),
            ),
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateEmployee(_selectedEmployee);
                        },
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
