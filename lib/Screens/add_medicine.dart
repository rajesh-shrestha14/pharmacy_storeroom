import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_storeroom/Model/medicine.dart';
import 'package:pharmacy_storeroom/Screens/added_medicine.dart';
import 'package:pharmacy_storeroom/Services/database_service.dart';
import 'package:pharmacy_storeroom/Services/get_from_shared_preference.dart';
import 'package:pharmacy_storeroom/Services/show_dialogue.dart';
import 'package:pharmacy_storeroom/myWidgets/date_picker.dart';
import 'package:pharmacy_storeroom/myWidgets/drawer.dart';
import 'package:pharmacy_storeroom/myWidgets/dropdown_menu.dart';

class AddMedicine extends StatefulWidget {
  //controllers
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  DateTime _medManufactureDate = DateTime.now();
  DateTime _medExpiryDate = DateTime.now();
//function to change _medManufactureDate
  changedManuDate(newValue) {
    setState(() {
      _medManufactureDate = newValue;
    });
  }

  //function to change _medExpiryfactureDate
  changedExpDate(newValue) {
    setState(() {
      _medExpiryDate = newValue;
    });
  }

  TextEditingController _medName = TextEditingController();
  TextEditingController _medPrice = TextEditingController();
  TextEditingController _medBatchNumber = TextEditingController();
  TextEditingController _medQuantity = TextEditingController();
  TextEditingController _medSupplier = TextEditingController();
  TextEditingController _medSupplierAddress = TextEditingController();
  TextEditingController _medSupplierContact = TextEditingController();
  String issueDepartment;

  var departments = ['Pharmacy Counter', 'Damaged & Expiry', 'Pharmacy Store'];

  String validator(value) {
    if (value.isEmpty) {
      return "Required Field*";
    } else
      return null;
  }

  GlobalKey<FormState> _formState = GlobalKey();

  //function when add medicine button is pressed
  Future<void> _addMedicine() async {
    //TODO: Dialog not showing as expected while adding medicine
    //1. show dialogue
    //1.1 get uid from shared prefs and userName from database using current userId
    //2. make medicine model
    //3. upload to database
    //4. close the dialog and show success/error dialogue
    String userId = await FromSharedPref().getString('userId');

    BuildContext ctx = context;
    if (userId != null) {
      MedicineModel newMedicine = MedicineModel(
        mId: '',
        mName: _medName.text,
        mPrice: double.parse(_medPrice.text),
        mManDate: _medManufactureDate,
        mExpDate: _medExpiryDate,
        mBatch: _medBatchNumber.text,
        mQuantity: double.parse(_medQuantity.text),
        mIssueBy: userId,
        mSupplier: _medSupplier.text,
        mSuppAddress: _medSupplierAddress.text,
        mSuppContact: _medSupplierContact.text,
        department: issueDepartment,
        uId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await DatabaseService().medicineToDatabase(newMedicine);
      Navigator.of(ctx).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => AddMedicine()),
        (Route<dynamic> route) => route is AddedMedicine,
      );
      DialogService().addedToDatabase(
          context: context,
          message: "medicine added successfully",
          title: 'Success');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              AppBarDropDownMenu().showDialogue(context);
            },
          )
        ],
        title: Text('Add Medicine'),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.06),
        color: Color(0xffebf1f6),
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MEDICINE DETAILS',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'INFORMATION',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Add Medicine Information Here',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.03),
                    //height: size.height * 0.5,
                    color: Colors.white,
                    child: Form(
                      key: _formState,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: validator,
                            controller: _medName,
                            decoration: InputDecoration(
                              labelText: 'Medicine Name',
                              hintText: 'type medicine name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: validator,
                            controller: _medPrice,
                            decoration: InputDecoration(
                              labelText: 'Medicine Price',
                              hintText: 'type medicine price',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          DateTimePicker(
                            title: "Manufacture Date",
                            setDate: changedManuDate,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          DateTimePicker(
                            title: "Expiry Date",
                            setDate: changedExpDate,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            validator: validator,
                            controller: _medBatchNumber,
                            decoration: InputDecoration(
                              labelText: 'Batch Number',
                              hintText: 'type batch number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: validator,
                            controller: _medQuantity,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              hintText: 'Quantity : Strip*packing',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            validator: validator,
                            controller: _medSupplier,
                            decoration: InputDecoration(
                              labelText: 'Supplier',
                              hintText: 'type Supplier Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            validator: validator,
                            controller: _medSupplierContact,
                            decoration: InputDecoration(
                              labelText: 'Supplier Contact',
                              hintText: 'type Supplier Contact',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextFormField(
                            validator: validator,
                            controller: _medSupplierAddress,
                            decoration: InputDecoration(
                              labelText: 'Supplier Address',
                              hintText: 'type Supplier Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          FormField<String>(
                            // initialValue: null,
                            validator: (value) {
                              if (issueDepartment == null)
                                return 'Please Select Department*';
                              return null;
                            },
                            builder: (context) {
                              return DropdownButton(
                                isExpanded: true,
                                hint: Container(
                                  child: Text(
                                    'Select Department',
                                  ),
                                ),
                                items: departments
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Center(
                                          child: Text(
                                            e,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (department) {
                                  setState(() {
                                    issueDepartment = department;
                                  });
                                },
                                value: issueDepartment,
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton.icon(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (_formState.currentState.validate()) {
                    _addMedicine();
                  }
                },
                icon: Icon(
                  Icons.lock_open,
                  color: Colors.blue,
                ),
                label: Text(
                  'Add Medicine Details',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
