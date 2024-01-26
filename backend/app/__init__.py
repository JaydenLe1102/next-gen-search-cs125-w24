from flask import Flask

from config import Config
from app.main import bp as main_bp
from dotenv import load_dotenv

def create_app(config_class=Config):

		load_dotenv()

		app = Flask(__name__)
		app.config.from_object(config_class)

		# Initialize Flask extensions here

		# Register blueprints here

		app.register_blueprint(main_bp)

		@app.route('/test/')
		def test_page():
				return '<h1>Testing the Flask Application Factory Pattern</h1>'

		return app