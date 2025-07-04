import 'package:duitse_gym_app/data/users.dart';
import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key, required this.user});
  final User user;

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {


  bool canShowSaveButton = false;
  bool showDateErrorText = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 60,
          child: Image.asset("assets/Icon.png"),
        ),
        centerTitle: false,
        title: Text("Membership", style: TextStyle(color: Colors.green),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Membership details"),
                          if (canShowSaveButton) TextButton(
                            onPressed: (){
                              _formKey.currentState?.save();
                              if (_formKey.currentState!.validate() && !showDateErrorText) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("saved"))
                                );
                              }
                            },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.green),
                            foregroundColor: WidgetStatePropertyAll(Colors.white)
                          ),
                          child: Text("save"),
                          )
                        ],
                      ),
                      TextFormField(
                        initialValue: widget.user.first_name,
                        onChanged: (value) {
                          setState(() {
                            canShowSaveButton = value != widget.user.first_name;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) return "value can not be empty";
                          if (value.length > 15) return "value can not be more than 15 characters";
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: "First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.green, width: 2)
                          )
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.user.last_name,
                        onChanged: (value) {
                          setState(() {
                            canShowSaveButton = value != widget.user.last_name;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) return "value can not be empty";
                          if (value.length > 15) return "value can not be more than 15 characters";
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: "Last name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.green, width: 2)
                          )
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_month),
                          Expanded(
                            child: InputDatePickerFormField(
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050),
                              initialDate: DateTime.now(),
                              onDateSaved: (value) {
                                 setState(() {
                                  final isUnderage = value.difference(DateTime(2025, 7, 4)).inDays > -(365 * 16);
                                  showDateErrorText = isUnderage;
                                });
                              },
                              onDateSubmitted: (selectedDate) {
                                setState(() {
                                  final isUnderage = selectedDate.difference(DateTime(2025, 7, 4)).inDays > -(365 * 16);
                                  showDateErrorText = isUnderage;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    if (showDateErrorText) Text("must be older than 16", style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  color: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Subscription Details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        Text("${widget.user.subscription.type} subscription"),
                        Text("Expires on ${widget.user.subscription.expiration_date.month}/${widget.user.subscription.expiration_date.day}/${widget.user.subscription.expiration_date.year}"),
                        Text("${_getValue()} Є/month")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getValue() {
    if (widget.user.subscription.type == "bronze") return "20";
    if (widget.user.subscription.type == "silver") return "25";
    return "35";
  }
}