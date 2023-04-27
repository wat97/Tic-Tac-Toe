import 'package:equatable/equatable.dart';

class ModelPlanGeneral extends Equatable {
  final int? id;
  final String title;
  final int startMoney;
  final int goalsMoney;
  final DateTime? startline;
  final DateTime? deadline;
  final bool statusPlanner;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ModelPlanGeneral({
    this.id,
    required this.title,
    this.startMoney = 0,
    required this.goalsMoney,
    this.startline,
    this.deadline,
    this.statusPlanner = false,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelPlanGeneral.fromJson(Map<String, dynamic> json) =>
      ModelPlanGeneral(
        id: json["id"],
        title: json["title"],
        startMoney: json["start_money"],
        goalsMoney: json["goals_money"],
        startline: json["startline"],
        deadline: json["deadline"],
        statusPlanner: json["status_planner"],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "start_money": startMoney,
        "goals_money": goalsMoney,
        "startline": startline == null ? "" : startline!.toIso8601String(),
        "deadline": deadline == null ? "" : deadline!.toIso8601String(),
        "status_planner": statusPlanner,
        "created_at": createdAt == null ? "" : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? "" : updatedAt!.toIso8601String(),
      };

  @override
  List<Object> get props => [id!];
}
