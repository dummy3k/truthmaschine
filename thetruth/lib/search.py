from whoosh.index import create_in
from whoosh.fields import *

import time
import os, os.path
from whoosh.filedb.filestore import FileStorage

from whoosh.qparser import QueryParser

class Search():
    def __init__(self):
        self.schema = Schema(message=TEXT(stored=True), id=ID(stored=True, id=True))

        index_path = "data/index"
        self.new_index = False
        
        if not os.path.exists(index_path):
            self.new_index = True
            os.mkdir(index_path)

        self.storage = FileStorage(index_path)
        
        if self.new_index:
            self.index = self.storage.create_index(self.schema)
        else:
            self.index = self.storage.open_index()
        
    def _create_writer(self): 
        if not hasattr(self, 'writer'):
            while True:
                try:
                    self.writer = self.index.writer()
                    break
                except e:
                    time.sleep(10)
        
    def add_to_index(self, statement):
        self._create_writer()
        self.writer.add_document(message=statement.message, \
                                 id=unicode(statement.id))
    def update_index(self, statement):
        self._create_writer()
        self.writer.update_document(message=statement.message, \
                                 id=unicode(statement.id))
    
    def add_to_index_and_commit(self, statement):
        self.add_to_index(statement)
        self.commit_index()
    
    def commit_index(self):
        self.writer.commit()

    def search(self, query):
        if not hasattr(self, 'parser'):
            self.parser = QueryParser("message", schema = self.schema)
            
        search_query = self.parser.parse(query)
            
        self.searcher = self.index.searcher()
        return self.searcher.search(search_query)
