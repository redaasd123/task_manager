import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/custom_text_field.dart';
import 'package:task_manager/feature/home/domain/entity/task_entity.dart';
import 'package:task_manager/feature/home/domain/param.dart';

class CreateBottomSheet extends StatefulWidget {
  CreateBottomSheet({super.key, this.taskEntity, required this.text});

  final TaskEntity? taskEntity;
  final String text;

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> stats = ['Urgent', 'Completed', 'Pending'];
  String? selectState;
  int titleCount = 0;
  int descCount = 0;

  double currentHeight = 0.65;

  @override
  void initState() {
    super.initState();

    if (widget.taskEntity != null) {
      titleCtrl.text = widget.taskEntity!.title;
      descCtrl.text = widget.taskEntity!.desc;
      selectState = widget.taskEntity!.state;
      titleCount = titleCtrl.text.length;
      descCount = descCtrl.text.length;
    }

    titleCtrl.addListener(() {
      setState(() {
        titleCount = titleCtrl.text.length;
        _updateHeight();
      });
    });

    descCtrl.addListener(() {
      setState(() {
        descCount = descCtrl.text.length;
        _updateHeight();
      });
    });
  }

  void _updateHeight() {
    double baseHeight = 0.65;
    double extra = (descCount / 500) * 0.3;
    currentHeight = (baseHeight + extra).clamp(0.65, 0.95);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final createTask = CreateTaskParam(
        title: titleCtrl.text.trim(),
        state: selectState ?? '',
        desc: descCtrl.text.trim(),
      );
      Navigator.pop(context, createTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: currentHeight,
      minChildSize: 0.65,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // Title Field
              CustomTextField(
                maxLength: 100,
                minLine: 1,
                readOnly: false,
                label: 'Title',
                hint: 'Enter Task Title',
                controller: titleCtrl,
                keyboardType: TextInputType.text,
                icon: Icon(Icons.title),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('$titleCount/100', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 15),

              // Description Field
              CustomTextField(
                maxLength: 500,
                minLine: 3,
                readOnly: false,
                label: 'Description',
                hint: 'Enter Task Description',
                controller: descCtrl,
                keyboardType: TextInputType.text,
                icon: Icon(Icons.description),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('$descCount/500', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 15),

              // Status Dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  value: selectState,
                  validator: _validator,
                  decoration: InputDecoration(
                    labelText: "Status",
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    prefixIcon: Icon(Icons.flag, color: Colors.deepPurple),
                  ),
                  items: stats.map((status) {
                    Color textColor;
                    switch (status) {
                      case 'Urgent':
                        textColor = Colors.red;
                        break;
                      case 'Completed':
                        textColor = Colors.green;
                        break;
                      default:
                        textColor = Colors.orange;
                    }
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          )),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectState = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),

              // Add Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    elevation: MaterialStateProperty.all(6),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.purpleAccent]),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validator(String? data) {
    if (data == null || data.trim().isEmpty) return 'من فضلك أدخل هذا الحقل';
    return null;
  }
}
