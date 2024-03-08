// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduleListing extends StatefulWidget {
  ScheduleListing({super.key, required this.listTodo});
  List<CongViec> listTodo;
  @override
  State<ScheduleListing> createState() => _ScheduleListingState();
}

final TextEditingController _controllerCv = TextEditingController();
DateTime selectedDate = DateTime.now();
String selectedTime = DateFormat('kk:mm').format(DateTime.now());

class _ScheduleListingState extends State<ScheduleListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            final itemnew = await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddSchedule(
                  listAdded: widget.listTodo,
                ),
              ),
            );
            if (itemnew != null) {
              setState(() {
                widget.listTodo.add(itemnew);
              });
            }
          },
        ),
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Align(
              alignment: Alignment.center,
              child: Text(
                "TO DO LIST",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        body: Container(
            color: Colors.transparent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Container(
                        child: widget.listTodo.isNotEmpty
                            ? ListView.builder(
                                itemCount: widget.listTodo.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    child: Card(
                                      borderOnForeground: true,
                                      color:
                                          const Color.fromRGBO(38, 38, 40, 200),
                                      elevation: 1,
                                      child: ListTile(
                                        title: Text(
                                          widget.listTodo[index].tenCv,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Date: ${DateFormat('dd-MM-yyyy').format(widget.listTodo[index].date)} | Time: ${widget.listTodo[index].time}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _controllerCv.text =
                                                widget.listTodo[index].tenCv;
                                            selectedDate =
                                                widget.listTodo[index].date;
                                            selectedTime =
                                                widget.listTodo[index].time;
                                          });
                                        },
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Do you want to remove?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Removed ${widget.listTodo[index].tenCv}",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16,
                                                        );
                                                        widget.listTodo
                                                            .removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Schedule available')),
                      ),
                    ),
                  ),
                ])));
  }
}

class AddSchedule extends StatefulWidget {
  List<CongViec> listAdded;

  AddSchedule({super.key, required this.listAdded});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final TextEditingController _controllerCv = TextEditingController();
  late DateTime selectedDate;
  late String selectedTime;

  @override
  void initState() {
    super.initState();
    resetDateTime();
  }

  void resetDateTime() {
    _controllerCv.clear();
    selectedDate = DateTime.now();
    selectedTime = DateFormat('kk:mm').format(DateTime.now());
  }

  Future<void> _selectedDate(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 3),
      lastDate: DateTime(2202),
    );
    if (picker != null && picker != selectedDate) {
      setState(() {
        selectedDate = picker;
      });
    }
  }

  Future<void> _selectedTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _controllerCv,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    hintText: 'what do you want to do?',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    alignLabelWithHint: true,
                    hoverColor: Color.fromARGB(255, 55, 234, 43),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Date:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: DateFormat('dd-MM-yyyy')
                                    .format(selectedDate),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: MaterialButton(
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              _selectedDate(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Time:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: selectedTime,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: MaterialButton(
                            child: const Icon(
                              Icons.av_timer_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              _selectedTime(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (_controllerCv.text.isNotEmpty) {
                            bool isAdded = false;
                            if (widget.listAdded.isEmpty) {
                              widget.listAdded.add(
                                CongViec(
                                  _controllerCv.text,
                                  selectedDate,
                                  selectedTime,
                                ),
                              );
                              resetDateTime();
                            } else {
                              for (int i = 0;
                                  i < widget.listAdded.length;
                                  i++) {
                                if (widget.listAdded[i].tenCv ==
                                    _controllerCv.text) {
                                  widget.listAdded[i].date = selectedDate;
                                  widget.listAdded[i].time = selectedTime;
                                  resetDateTime();
                                  isAdded = true;
                                  break;
                                }
                              }
                              if (!isAdded) {
                                widget.listAdded.add(
                                  CongViec(
                                    _controllerCv.text,
                                    selectedDate,
                                    selectedTime,
                                  ),
                                );
                                resetDateTime();
                              }
                            }
                            print(widget.listAdded);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScheduleListing(
                                  listTodo: widget.listAdded,
                                ),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Please fill your input todo name',
                            );
                          }
                        });
                      },
                      child: const Text(
                        "ADD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ]));
  }
}

class CongViec {
  String tenCv;
  DateTime date;
  String time;
  CongViec(this.tenCv, this.date, this.time);
  @override
  String toString() {
    return "$tenCv-${DateFormat('dd-MM-yyyy').format(date)} - $time";
  }
}
