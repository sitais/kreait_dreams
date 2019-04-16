import 'package:kreait_dreams/kreait_dreams.dart';

import 'package:kreait_dreams/model/dream.dart';

class DreamsController extends ResourceController {
  DreamsController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllDreams() async {
    final dreamQuery = Query<Dream>(context);
    return Response.ok(await dreamQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getDream(@Bind.path('id') int id) async {
    final dreamQuery = Query<Dream>(context)
      ..where((dream) => dream.id).equalTo(id);
    final dream = await dreamQuery.fetchOne();

    if (dream == null) {
      return Response.notFound(body: 'Item not found');
    }
    return Response.ok(dream);
  }

  @Operation.post()
  Future<Response> createNewDream(@Bind.body() Dream body) async {
    final dreamQuery = Query<Dream>(context)
      ..values = body;
    final insertedDream = await dreamQuery.insert();

    return Response.ok(insertedDream);
  }

  @Operation.put('id')
  Future<Response> updatedDream(
    @Bind.path('id')int id, 
    @Bind.body() Dream body,
    ) async {
      final dreamQuery = Query<Dream>(context)
        ..values = body
        ..where((dream) => dream.id).equalTo(id);

      final updatedQuery = await dreamQuery.updateOne();

      if (updatedQuery == null) {
        return Response.notFound(body: 'Item not found.');
    }
    return Response.ok(updatedQuery);
  }

  @Operation.delete('id')
  Future<Response> deletedDream(@Bind.path('id') int id) async {
    final dreamQuery = Query<Dream>(context)
      ..where((dream) => dream.id).equalTo(id);

    final int deletedCount = await dreamQuery.delete();
    
    if (deletedCount == 0) {
       return Response.notFound(body: 'Item not found.');
    }
    return Response.ok('Deleted $deletedCount items.');
  }
}