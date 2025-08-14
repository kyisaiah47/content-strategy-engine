export default function Home() {
	return (
		<div className="min-h-screen bg-gray-50 p-8">
			<div className="max-w-4xl mx-auto">
				<h1 className="text-4xl font-bold text-gray-900 mb-4">Contentr</h1>
				<p className="text-xl text-gray-600 mb-8">
					AI-powered content strategy and automation for TiDB AgentX Hackathon
					2025
				</p>

				<div className="grid grid-cols-1 md:grid-cols-3 gap-6">
					<div className="bg-white p-6 rounded-lg shadow">
						<h2 className="text-xl font-semibold mb-2">Content Gap Analysis</h2>
						<p className="text-gray-600">AI identifies content opportunities</p>
					</div>

					<div className="bg-white p-6 rounded-lg shadow">
						<h2 className="text-xl font-semibold mb-2">Auto Calendar</h2>
						<p className="text-gray-600">Generate 30-day content strategy</p>
					</div>

					<div className="bg-white p-6 rounded-lg shadow">
						<h2 className="text-xl font-semibold mb-2">Automation</h2>
						<p className="text-gray-600">Schedule and track performance</p>
					</div>
				</div>

				<div className="mt-8 p-4 bg-blue-50 rounded-lg">
					<h3 className="font-semibold text-blue-900">Demo Status</h3>
					<p className="text-blue-700">
						🚀 Repository generated successfully! Add your TiDB and OpenAI API
						keys to .env to enable full functionality.
					</p>
				</div>
			</div>
		</div>
	);
}
